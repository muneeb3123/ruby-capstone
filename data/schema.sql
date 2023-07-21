CREATE TABLE Author(
  id INTEGER PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL
);

CREATE TABLE Game(
  id INT PRIMARY KEY REFERENCES items(id),
  last_played_at DATE NOT NULL,
  multiplayer BOOLEAN NOT NULL
);

CREATE TABLE music_album (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  publish_date DATE NOT NULL,
  artist TEXT NOT NULL,
  total_tracks INTEGER NOT NULL,
  on_spotify BOOLEAN NOT NULL,
  genre_id INTEGER,
  FOREIGN KEY (genre_id) REFERENCES genre(id)
);

CREATE TABLE genre (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  description TEXT NOT NULL
);
