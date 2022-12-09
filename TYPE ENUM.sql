CREATE TABLE chess_title
(
	title_id serial PRIMARY KEY,
	title text
);

CREATE TABLE chess_player 
(
	player_id serial PRIMARY KEY,
	first_name text,
	last_name text,
	title_id int REFERENCES chess_title(title_id)
);

INSERT INTO chess_title (title)
VALUES 
('Candidate Master'),
('FIDE Master'),
('International Master'),
('Grand Master');

SELECT * FROM chess_title;

INSERT INTO chess_player(first_name, last_name, title_id)
VALUES
('Wesley', 'So', 4),
('Vlad', 'Kramnik', 4),
('Vasily', 'Pupkin', 1);

SELECT * FROM chess_player
JOIN chess_title USING(title_id);

DROP TABLE chess_title; --CASCADE
DROP TABLE chess_player;

CREATE TYPE chess_title AS ENUM 
('Candidate Master',
'FIDE Master',
'International Master');

SELECT enum_range(null::chess_title);

ALTER TYPE chess_title
ADD VALUE 'Grand Master' AFTER 'International Master'; --before

CREATE TABLE chess_player 
(
	player_id serial PRIMARY KEY,
	first_name text,
	last_name text,
	title chess_title
);

INSERT INTO chess_player(first_name, last_name, title)
VALUES
('Wesley', 'So', 'Grand Master');