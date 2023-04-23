BEGIN;
CREATE TABLE users (
    id          text        NOT NULL PRIMARY KEY,
    name        text        NOT NULL,
    email       text        NOT NULL,
    password    text        NOT NULL,
    avatar      text        NOT NULL,
    guilds      text[]      NOT NULL,
    friends     text[]      NOT NULL,
    created_at  timestamp   NOT NULL,
    updated_at  timestamp   NOT NULL
);
CREATE TABLE guilds (
    id          text        NOT NULL PRIMARY KEY,
    name        text        NOT NULL,
    owner       text        NOT NULL,
    created_at  timestamp   NOT NULL,
    updated_at  timestamp   NOT NULL,
    permissions json        NOT NULL
);
CREATE TABLE members (
    user_id     text        NOT NULL,
    guild_id    text        NOT NULL,
    joined_at   timestamp   NOT NULL,
    permissions json       NOT NULL,
    roles       text[]      NOT NULL,
    PRIMARY KEY (user_id, guild_id)
);
CREATE TYPE channel_type AS ENUM ('text', 'voice');
CREATE TABLE channels (
    id          text            NOT NULL PRIMARY KEY,
    type        channel_type    NOT NULL,
    name        text            NOT NULL,
    guild_id    text            NOT NULL,
    created_at  timestamp       NOT NULL,
    updated_at  timestamp       NOT NULL,
    permissions json           NOT NULL
);
CREATE TABLE messages (
    id          text        NOT NULL PRIMARY KEY,
    guild_id    text        NOT NULL, -- this might be redundant
    channel_id  text        NOT NULL,
    user_id     text        NOT NULL,
    content     text        NOT NULL,
    created_at  timestamp   NOT NULL,
    updated_at  timestamp   NOT NULL
);
CREATE TABLE roles (
    id          text        NOT NULL PRIMARY KEY,
    name        text        NOT NULL,
    guild_id    text        NOT NULL,
    created_at  timestamp   NOT NULL,
    updated_at  timestamp   NOT NULL,
    created_by  text        NOT NULL,
    permissions json       NOT NULL
);
COMMIT;