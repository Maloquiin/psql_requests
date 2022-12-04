insert into customers(customer_id, contact_name, city, country, company_name)
values 
('AAAAX', 'Lfred Mann', 'abc', 'USA', 'fake_company'),
('BBBBC', 'Lfred Mann', 'acb', 'Austria','fake_company'),
('AAAAZ', 'Alfred Mann', NULL, 'USA', 'fake_company'),
('BBBBE', 'Alfred Mann', NULL, 'Austria','fake_company');

SELECT contact_name, city, country
FROM customers
ORDER BY contact_name,
(
	CASE WHEN city IS NULL THEN country
		 ELSE city
	END
);

SELECT contact_name, city, country
FROM customers
ORDER BY contact_name, COALESCE(city, country);

SELECT product_name, unit_price, 
CASE WHEN unit_price >= 100 THEN 'too expensive'
	 WHEN unit_price >= 50 AND unit_price < 100 THEN 'average'
	 WHEN unit_price < 50 THEN 'low price'
END AS try_cost
FROM products;

SELECT contact_name, COALESCE(order_id::text, 'no orders')
FROM customers
LEFT JOIN orders USING(customer_id)
WHERE order_id IS NULL;

SELECT CONCAT(first_name, ' ', last_name) AS full_name, COALESCE(NULLIF(title,'Sales Representative'),'Sales Stuff') as title
FROM employees;