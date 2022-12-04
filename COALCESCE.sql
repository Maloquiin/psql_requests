SELECT *
FROM orders
LIMIT 10;

SELECT order_id, order_date, COALESCE(ship_region, 'unknown') AS ship_region
FROM orders
LIMIT 10;

SELECT *
FROM employees;

SELECT last_name, first_name, COALESCE(region, 'unknown') AS region
FROM employees;

SELECT *
FROM customers;

SELECT contact_name, COALESCE(NULLIF(city, ''), 'Need edit') as city
FROM customers;