PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS replies;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
); 

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(50) NOT NULL,
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

INSERT INTO
    users (fname, lname)
VALUES
    ('Ben', 'Lim'),
    ('Sean', 'Mackey'),
    ('Kirby', 'Neaton'),
    ('Evan', 'Leon');

INSERT INTO
    questions (title, body, users_id)
VALUES
    ('Data Types', 'What is the difference between LIFO & FIFO', (SELECT id FROM users WHERE fname = 'Sean' AND lname = 'Mackey')),
    ('SQL', 'Why do we need line PRAGMA foreign_keys = ON to make sure we reference a table when the code can only work when it does reference a table', (SELECT id FROM users WHERE fname = 'Ben'  AND lname = 'Lim'));

INSERT INTO
  replies (questions_id, reply_id, users_id, body)
VALUES
  ((
    SELECT
      questions.id
    FROM  
      questions
    WHERE
      users_id = 1
  ), NULL, (
    SELECT
      users.id
    FROM
      users
    WHERE
      fname = "Evan"
  ), "The difference between LIFO and FIFO is that LIFO is last in first out and FIFO is first in first out."
  );

  INSERT INTO
    question_follows (users_id, questions_id)
  VALUES
    ((SELECT id FROM users WHERE fname = 'Ben' AND lname = 'Lim'),
    (SELECT id FROM questions WHERE id = 1)
    );

  INSERT INTO
    question_likes (users_id, questions_id)
  VALUES
    ((SELECT id FROM users WHERE fname = 'Ben' AND lname = 'Lim'),
    (SELECT id FROM questions WHERE id = 1)
    );
