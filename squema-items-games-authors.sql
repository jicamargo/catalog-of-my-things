-- schema.sql

-- Table for items
CREATE TABLE Items (
  id SERIAL PRIMARY KEY,
  genre VARCHAR(255),
  label VARCHAR(255),
  publish_date DATE,
  archived BOOLEAN
);

-- Table for games
CREATE TABLE Games (
  id SERIAL PRIMARY KEY,
  multiplayer BOOLEAN,
  last_played_at DATE,
  item_id INTEGER REFERENCES Items(id),
  FOREIGN KEY (item_id) REFERENCES Items(id)
);

-- Table for authors
CREATE TABLE Authors (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);

-- Table for items_authors relationship
CREATE TABLE Items_Authors (
  item_id INTEGER REFERENCES Items(id),
  author_id INTEGER REFERENCES Authors(id),
  PRIMARY KEY (item_id, author_id)
);

-- Book
CREATE TABLE book(
    id INT GENERATED ALWAYS AS IDENTITY,
    publish_date DATE NOT NULL,
    archived BOOLEAN,
    publisher VARCHAR(100) NOT NULL,
    cover_state VARCHAR(55) NOT NULL,
    genre_id INT NOT NULL,
    author_id INT NOT NULL,
    label_id INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (genre_id) REFERENCES genre(id),
    FOREIGN KEY (author_id) REFERENCES authors(id),
    FOREIGN KEY (label_id) REFERENCES label(id),
);

-- Label
CREATE TABLE label(
    id INT GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(255) NOT NULL,
    color VARCHAR(55) NOT NULL,
    PRIMARY KEY(id)
);

-- Genre
CREATE TABLE genre(
    id INT GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);

-- MusicAlbum
CREATE TABLE music_album(
    id INT GENERATED ALWAYS AS IDENTITY,
    publish_date DATE NOT NULL,
    archived BOOLEAN,
    label_id INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (label_id) REFERENCES label(id)
);
