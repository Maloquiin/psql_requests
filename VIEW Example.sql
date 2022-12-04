CREATE VIEW order1 AS
SELECT order_date, required_date, shipped_date, ship_postal_code, 
company_name, contact_name, phone, 
last_name, first_name, title
FROM orders
JOIN customers USING(customer_id)
JOIN employees USING(employee_id);

SELECT *
FROM order1
WHERE order_date > '1997-01-01';

CREATE VIEW order2 AS
SELECT order_date, required_date, shipped_date, ship_postal_code, ship_country, company_name, contact_name, 
phone, last_name, first_name, title
FROM orders
JOIN customers USING(customer_id)
JOIN employees USING(employee_id);

CREATE OR REPLACE VIEW order2 AS
SELECT order_date, required_date, shipped_date, ship_country, ship_postal_code, reports_to, 
company_name, contact_name, 
phone, last_name, first_name, title
FROM orders
JOIN customers USING(customer_id)
JOIN employees USING(employee_id);

ALTER VIEW order2
RENAME TO order2_old;

SELECT *
FROM order2
ORDER BY ship_country;

DROP VIEW order2_old;

CREATE VIEW order3 AS
SELECT *
FROM products
WHERE discontinued = 0
WITH LOCAL CHECK OPTION;

SELECT *
FROM order3

INSERT INTO order3
VALUES
(122, 'test', 1, 5, '2', 10, 10, 70, 25, 1)