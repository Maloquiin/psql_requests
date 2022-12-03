CREATE TABLE teacher
(
	teacher_id serial,
	first_name varchar,
	last_name varchar,
	birthday date,
	phone varchar,
	title varchar
);

ALTER TABLE teacher
ADD COLUMN middle_name varchar;

ALTER TABLE teacher
DROP COLUMN middle_name;

ALTER TABLE teacher
RENAME birthday TO birthday_date;

ALTER TABLE teacher
ALTER COLUMN phone SET DATA TYPE varchar(32);

CREATE TABLE exam
(
	exam_id serial,
	exan_name varchar(256),
	exam_date date
);

ALTER TABLE exam
RENAME exan_name TO exam_name;

INSERT INTO exam (exam_name, exam_date)
VALUES
('Test 1','2000-12-24'),
('Test 2','1999-05-12'),
('Test 3','2048-08-07');

SELECT * FROM exam;

TRUNCATE TABLE exam RESTART IDENTITY;