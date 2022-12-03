CREATE TABLE exam
(
	exam_id int GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL,
	exam_name varchar(36) NOT NULL,
	exam_date date NOT NULL,
	
	CONSTRAINT PK_exam_exam_id PRIMARY KEY(exam_id)
)

ALTER TABLE exam
ALTER COLUMN exam_id DROP IDENTITY;

ALTER TABLE exam
ADD CONSTRAINT PK_exam_exam_id PRIMARY KEY(exam_id);

CREATE TABLE person
(
	person_id int,
	first_name varchar(32) NOT NULL,
	last_name varchar(32) NOT NULL,
	
	CONSTRAINT PK_person_person_id PRIMARY KEY(person_id)
);

CREATE TABLE passport
(
	passport_id int,
	serial_number int NOT NULL,
	registration text,
	person_id int,
	
	CONSTRAINT PK_passport_passport_id PRIMARY KEY(passport_id),
	CONSTRAINT FK_passport_person_id FOREIGN KEY(person_id) REFERENCES person(person_id)
);


ALTER TABLE book
ADD COLUMN freight decimal CONSTRAINT CHK_book_freight CHECK (freight > 0 and freight < 100);

INSERT INTO book
VALUES
(10,'title10', 'isbn', 4, 10);

CREATE TABLE student
(
	student_id int GENERATED ALWAYS AS IDENTITY NOT NULL,
	full_name text,
	course int DEFAULT 1
);

INSERT INTO student (full_name)
VALUES ('Nikolai Markov')
RETURNING *

ALTER TABLE student
ALTER COLUMN course DROP DEFAULT;

