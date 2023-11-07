use actix_web::{
    post,
    web::{Data, Path},
    HttpResponse,
};
use serde::Deserialize;
use utoipa::IntoParams;

use crate::{
    auth::user::User,
    db::DB,
    error::{macros::err, HResult},
    realtime::pubsub::consumer_manager::EventConsumerManager,
};

#[derive(Deserialize, IntoParams)]
pub struct TypingPath {
    guild_id: String,
    channel_id: String,
}

/// Typing
///
/// Notify the target channel that you are typing a message. Please call this
/// endpoint every `4s` while the user is still typing to maintain their status.
#[utoipa::path(
    tag = "messaging",
    security(("token" = [])),
    params(TypingPath),
    responses(
        (status = OK, description = "Typing notification sent"),
        (status = FORBIDDEN, description = "No permission to type messages in channel"),
    )
)]
#[post("/guilds/{guild_id}/channels/{channel_id}/typing")]
pub async fn typing(
    db: DB,
    path: Path<TypingPath>,
    user: User,
    ecm: Data<EventConsumerManager>,
) -> HResult<HttpResponse> {
    if !db
        .can_user_send_message_in(&user.id, &path.guild_id, &path.channel_id)
        .await?
    {
        return err!(403);
    }

    ecm.send_typing(&path.channel_id, &user).await;

    Ok(HttpResponse::Ok().finish())
}
