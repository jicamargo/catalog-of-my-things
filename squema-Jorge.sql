-- schema.sql

-- Table for items
CREATE TABLE Items (
  id SERIAL PRIMARY KEY,
  genre VARCHAR(255),
  author_first_name VARCHAR(255),
  author_last_name VARCHAR(255),
  label VARCHAR(255),
  publish_date DATE,
  archived BOOLEAN
);

-- Table for games
CREATE TABLE Games (
  id SERIAL PRIMARY KEY,
  multiplayer BOOLEAN,
  last_played_at DATE,
  genre VARCHAR(255),
  author_first_name VARCHAR(255),
  author_last_name VARCHAR(255),
  label VARCHAR(255),
  publish_date DATE,
  archived BOOLEAN
);

-- Table for authors
CREATE TABLE Authors (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);
