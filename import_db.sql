PRAGMA foreign_keys = ON;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL,
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  users_id INTEGER NOT NULL,

  FOREIGN KEY (users_id) REFERENCES users(id) 
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  users_id INTEGER NOT NULL,
  questions_id INTEGER NOT NULL,

  FOREIGN KEY (users_id) REFERENCES users(id) 
  FOREIGN KEY (questions_id) REFERENCES questions(id) 
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  questions_id INTEGER NOT NULL,
  reply_id INTEGER,
  users_id INTEGER NOT NULL,
  body TEXT NOT NULL,

  FOREIGN KEY (questions_id) REFERENCES questions(id)
  FOREIGN KEY (reply_id) REFERENCES replies(id)
  FOREIGN KEY (users_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  users_id INTEGER NOT NULL,
  questions_id INTEGER NOT NULL,

  FOREIGN KEY (questions_id) REFERENCES questions(id)
  FOREIGN KEY (users_id) REFERENCES users(id)
);