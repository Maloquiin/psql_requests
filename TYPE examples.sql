

create or replace function get_salary_boundaries_by_city_with_type(
	emp_city varchar) RETURNS SETOF salary_boundaries
AS 
$$
	SELECT MIN(salary) AS min_salary,
	   	   MAX(salary) AS max_salary
  	FROM employees
	WHERE city = emp_city
$$ language sql;

SELECT get_salary_boundaries_by_city_with_type('London');

CREATE TYPE salary_boundaries AS (
	min_salary numeric,
	max_salary numeric
)

CREATE TYPE army_title AS ENUM (
	'Private',
	'Corporal',
	'Sergeant'
)

SELECT enum_range(null::army_title);

ALTER TYPE army_title
ADD VALUE 'Major' AFTER 'Sergeant';

CREATE TABLE person_army
(
	person_id serial PRIMARY KEY,
	first_name text,
	last_name text,
	person_rank army_title
)

INSERT INTO person_army (first_name,last_name,person_rank)
VALUES ('John', 'Corda', 'Major');

SELECT * FROM person_army;