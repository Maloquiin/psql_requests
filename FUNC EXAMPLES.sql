--backup table in other table
CREATE OR REPLACE FUNCTION backup_customers_tool() RETURNS void AS $$
	DROP TABLE IF EXISTS backedup_customers;
	
	CREATE TABLE backedup_customers AS 
	SELECT * FROM customers;
	--SELECT * INTO backedup_customers
	--FROM customers;
$$ LANGUAGE SQL;


SELECT backup_customers_tool();
SELECT * FROM backedup_customers;

-- avg freiht from orders
CREATE OR REPLACE FUNCTION get_avg_freight_by_orders() RETURNS float8 AS $$
	SELECT AVG(freight)
	FROM orders;
$$ LANGUAGE SQL;

SELECT * FROM get_avg_freight_by_orders();

--
CREATE OR REPLACE FUNCTION random_between(low int, high int) RETURNS int AS $$
BEGIN
	RETURN floor(random() * (high - low + 1) + low);
END;
$$ LANGUAGE plpgsql;

SELECT random_between(1,9)
FROM generate_series(1,10);

--------------------------
CREATE OR REPLACE FUNCTION get_salary_bounds_by_city(emp_city varchar, out min_salary numeric, out max_salary numeric) AS $$
SELECT MIN(salary), MAX(salary)
FROM employees
WHERE city = emp_city
$$ LANGUAGE SQL;

SELECT * FROM get_salary_bounds_by_city('London');

--------------------------
DROP FUNCTION IF EXISTS correct_salary;
CREATE OR REPLACE FUNCTION correct_salary(upper_boundary numeric DEFAULT 70, correction_rate numeric DEFAULT 0.15) 
RETURNS TABLE(last_name text, first_name text, title text, salary numeric) AS $$
	UPDATE employees
	SET salary = salary + (salary * correction_rate)
	WHERE salary <= upper_boundary
	RETURNING last_name, first_name, title, salary;
$$ LANGUAGE SQL;

SELECT * FROM correct_salary();
SELECT salary FROM employees ORDER BY salary;


---

CREATE OR REPLACE FUNCTION get_orders_by_shipping(ship_method int) RETURNS SETOF orders AS $$
DECLARE 
	average numeric;
	maximum numeric;
	middle numeric;
BEGIN
	SELECT MAX(freight) INTO maximum
	FROM orders
	WHERE ship_via = ship_method;
	
	SELECT AVG(freight) INTO average
	FROM orders
	WHERE ship_via = ship_method;
	
	maximum = maximum - (maximum * 0.3);
	
	middle = (maximum + average) / 2;
	
	RETURN QUERY 
	SELECT * FROM orders
	WHERE freight < middle;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_orders_by_shipping(1);

--------------
CREATE OR REPLACE FUNCTION should_increase_salary(
	cur_salary numeric,
	max_salary numeric DEFAULT 80,
	min_salary numeric DEFAULT 30,
	increase_rate numeric DEFAULT 0.2
) RETURNS bool AS
$$
DECLARE
	new_salary numeric;
BEGIN
	IF cur_salary >= max_salary OR cur_salary >= min_salary THEN
		RETURN false;
	END IF;
	
	IF cur_salary < min_salary THEN
		new_salary = cur_salary + (cur_salary * increase_rate);
	END IF;
	
	IF new_salary > max_salary THEN
		RETURN false;
	ELSE RETURN true;
	END IF;
END;
$$ LANGUAGE plpgsql;

SELECT should_increase_salary(40, 80, 30, 0.2);
SELECT should_increase_salary(79, 81, 80, 0.2);
SELECT should_increase_salary(79, 95, 80, 0.2);

















