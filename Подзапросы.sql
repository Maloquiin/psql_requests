SELECT company_name, country
FROM suppliers
WHERE country IN (SELECT DISTINCT country
FROM customers);

SELECT DISTINCT suppliers.company_name, country
FROM suppliers
JOIN customers USING(country);

SELECT category_name, SUM(units_in_stock)
FROM products
INNER JOIN categories USING(category_id)
GROUP BY category_name
ORDER BY SUM(units_in_stock) DESC
LIMIT (SELECT MIN(product_id) + 4 FROM products);

SELECT AVG(units_in_stock)
FROM products;

SELECT product_name, units_in_stock
FROM products
WHERE units_in_stock > (SELECT AVG(units_in_stock)
						FROM products)
ORDER BY units_in_stock