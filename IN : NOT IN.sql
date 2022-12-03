SELECT *
FROM products
WHERE unit_price > 25 AND units_in_stock > 40;

SELECT *
FROM customers
WHERE city = 'Berlin' or city = 'London' or city = 'San Francisco';

SELECT *
FROM orders
WHERE shipped_date > '1998-04-30' AND (freight < 75 OR freight > 150);

SELECT *
FROM orders
WHERE freight >= 20 and freight <= 40;

SELECT COUNT(*)
FROM orders
WHERE  freight BETWEEN 20 AND 40;

SELECT *
FROM orders
WHERE order_date BETWEEN '1998-03-30' AND '1998-04-03';

SELECT *
FROM customers
WHERE country = 'Mexico' OR country = 'Germany' OR country = 'USA' OR country = 'Canada';

SELECT *
FROM customers
WHERE country IN ('Mexico','Germany','USA', 'Canada');

SELECT *
FROM products
WHERE category_id IN (1,3,5,7);

SELECT *
FROM customers
WHERE country NOT IN ('Mexico','Germany','USA', 'Canada');

SELECT *
FROM products
WHERE category_id NOT IN (1,3,5,7);