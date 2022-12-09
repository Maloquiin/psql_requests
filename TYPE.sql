drop function if exists get_price_boundaries;
create or replace function get_price_boundaries (out max_price real, out min_price real)
returns cetof record ac Sc
select max (unit_price), min (unit_price)
from products
§$ language sql;

select * from get_price_boundaries();

CREATE TYPE price_bounds AS (
	max_price real,
	min_price real
);

CREATE FUNCTION get_price_boundaries() RETURNS SETOF price_bounds AS $$
	SELECT max (unit_price), min (unit_price)
	FROM products
$$ LANGUAGE SQL;

select * from get_price_boundaries();

CREATE TYPE complex AS(
	r float8,
	i float8
);

CREATE TABLE math_calcs(
	math_id serial,
	val complex
);

INSERT INTO math_calcs(val)
VALUES 
(ROW(3.0,4.0)),
(ROW(3.0,4.0));

SELECT * FROM math_calcs;

SELECT(val).r FROM math_calcs;

SELECT (val).* FROM math_calcs;

UPDATE math_calcs
SET val = ROW(1.0, 5.0)
WHERE math_id = 1;

UPDATE math_calcs
SET val.r = 7.0
WHERE math_id = 2;

UPDATE math_calcs
SET val.r = (val).r - 7.0
WHERE math_id = 2;