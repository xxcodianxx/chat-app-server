use utoipa::OpenApi;

pub mod pubsub;
pub mod pubsub_map;
pub mod events;
pub mod topic;

#[derive(OpenApi)]
#[openapi(
    tags(
        (name = "pubsub")
    ),
    paths(
        events::events_ws
    ),
)]
pub struct PubSubApiDoc;
