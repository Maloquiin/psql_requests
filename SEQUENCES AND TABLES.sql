DROP TABLE IF EXISTS book;

CREATE TABLE book
(
	book_id int GENERATED ALWAYS AS IDENTITY (START WITH 10 INCREMENT BY 2) NOT NULL,
	title text NOT NULL,
	isbn varchar(32) NOT NULL,
	publisher_id int NOT NULL,
	
	CONSTRAINT PK_book_book_id PRIMARY KEY(book_id)
);

SELECT * FROM book;

CREATE SEQUENCE IF NOT EXISTS book_book_book_id_seq
START WITH 1 OWNED BY book.book_id;

INSERT INTO book(title, isbn, publisher_id)
VALUES('title', 'isbn', 1)

ALTER TABLE book
ALTER COLUMN book_id SET DEFAULT nextval('book_book_book_id_seq');