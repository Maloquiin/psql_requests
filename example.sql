DROP TABLE IF EXISTS book;
DROP table If EXISTS author;

CREATE TABLE book
(
	book_id int PRIMARY KEY,
	title text NOT NULL,
	idbn text NOT NULL
);

CREATE TABLE author
(
	author_id int PRIMARY KEY,
	full_name text NOT NULL,
	rating real
);

CREATE TABLE book_author
(
	book_id int REFERENCES book(book_id),
	author_id int REFERENCES author(author_id),
	
	CONSTRAINT book_author_pkey PRIMARY KEY (book_id, author_id) -- composite key
);

INSERT INTO book
values
	(1, 'Book for Dummies', '123456'), 
	(2, 'Book for Smart Guys', '7890123'), 
	(3, 'Book for Happy People', '45678901'), 
	(4, 'Book for Unhappy People', '123456734')
;
	
INSERT INTO author
values

	(1, 'Bob', 4.5), 
	(2, 'Alice', 4.0), 
	(3, 'John', 4.7);

INSERT INTO book_author
values
	(1, 1),
	(2, 1),
	(3, 1),
	(3, 2),
	(4, 1),
	(4, 2),
	(4, 3)
	
