BEGIN;

UPDATE employees
SET salary = salary * 1.5
WHERE salary < 30;

SAVEPOINT salary_backup;

UPDATE employees
SET salary = salary * 0.8
WHERE salary > 80;

ROLLBACK TO salary_backup;

UPDATE employees
SET salary = 0
WHERE employee_id = 8

COMMIT;

--ROLLBACK;

SELECT * FROM employees;

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;

WITH prod_update AS (
	UPDATE products
	SET discontinued = 1
	WHERE units_in_stock < 10
	RETURNING product_id
)
SELECT * INTO last_orders_on_dicontinued
FROM order_details
WHERE product_id IN (SELECT product_id FROM prod_update);

SAVEPOINT backup;

DELETE FROM order_details
WHERE product_id IN (SELECT product_id FROM last_orders_on_dicontinued);

ROLLBACK TO backup;

UPDATE order_details
SET quantity = 0
WHERE product_id IN (SELECT product_id FROM last_orders_on_dicontinued);

SELECT Count(*) FROM order_details;
--DROP TABLE last_orders_on_dicontinued1;
--ROLLBACK;

COMMIT;

SELECT * FROM order_details
WHERE product_id IN (SELECT product_id FROM last_orders_on_dicontinued);

SELECT * FROM last_orders_on_dicontinued;

DROP TABLE IF EXISTS last_orders_on_dicontinued;