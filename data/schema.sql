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
