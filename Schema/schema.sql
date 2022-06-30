CREATE DATABASE catalog;

CREATE TABLE catalog.label (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    color VARCHAR(255)
);

CREATE TABLE catalog.author (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL
    last_name VARCHAR(255) NOT NULL
);

CREATE TABLE catalog.genre (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE catalog.item (
    id SERIAL PRIMARY KEY,
    publish_date DATE NOT NULL,
    author_id INTEGER NOT NULL,
    genre_id INTEGER NOT NULL,
    label_id INTEGER NOT NULL,
    archived BOOLEAN NOT NULL,
    CONSTRAINT item_author_id_fk FOREIGN KEY (author_id) REFERENCES catalog.author (id),
    CONSTRAINT item_genre_id_fk FOREIGN KEY (genre_id) REFERENCES catalog.genre (id),
    CONSTRAINT item_label_id_fk FOREIGN KEY (label_id) REFERENCES catalog.label (id),
);

CREATE TABLE catalog.game (
    id SERIAL PRIMARY KEY,
    item_id INTEGER NOT NULL,
    multiplayer BOOLEAN NOT NULL,
    last_played_at DATE NOT NULL,
    CONSTRAINT game_item_id_fk FOREIGN KEY (item_id) REFERENCES catalog.item (id)
);

CREATE TABLE catalog.book (
    id SERIAL PRIMARY KEY,
    item_id INTEGER NOT NULL,
    publisher VARCHAR(255) NOT NULL,
    cover_state VARCHAR(255) NOT NULL,
    CONSTRAINT book_item_id_fk FOREIGN KEY (item_id) REFERENCES catalog.item (id)
);

CREATE TABLE catalog.music_albums (
    id SERIAL PRIMARY KEY,
    item_id INTEGER NOT NULL,
    on_spotify BOOLEAN NOT NULL,
    CONSTRAINT music_albums_item_id_fk FOREIGN KEY (item_id) REFERENCES catalog.item (id)
);