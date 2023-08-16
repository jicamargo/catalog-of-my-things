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
