CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name text,
  word text,
  number integer
);

INSERT INTO users (name, word, number) VALUES ('Alice', 'apple', 1);
INSERT INTO users (name, word, number) VALUES ('Bob', 'banana', 2);
