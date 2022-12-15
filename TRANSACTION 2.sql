BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;

DROP TABLE IF EXISTS archive_poor_customers;

CREATE TABLE archive_poor_customers AS 
	SELECT customer_id, company_name, SUM(unit_price * quantity) AS total
	FROM orders
	JOIN order_details USING(order_id)
	JOIN customers USING(customer_id)
	GROUP BY company_name, customer_id
	HAVING SUM(unit_price * quantity) < 2000
	ORDER BY SUM(unit_price * quantity)

	DELETE FROM order_details
	WHERE order_id IN (SELECT order_id
					   FROM orders
					   WHERE customer_id IN (SELECT customer_id FROM archive_poor_customers)
					  );
	DELETE FROM orders
	WHERE customer_id IN (SELECT customer_id FROM archive_poor_customers);
	DELETE FROM customers
	WHERE customer_id IN (SELECT customer_id FROM archive_poor_customers);
	
--ROLLBACK;
COMMIT;

SELECT * FROM archive_poor_customers;

SELECT * FROM archive_products_disc;

BEGIN;

DROP TABLE IF EXISTS archive_products_disc;

CREATE TABLE archive_products_disc AS
	SELECT * FROM products
	WHERE discontinued = 1;
	
SAVEPOINT backup_products;

DELETE FROM order_details
WHERE product_id IN (SELECT product_id FROM archive_products_disc);

DELETE FROM products
WHERE discontinued = 1;

ROLLBACK TO backup_products;

COMMIT;