SELECT contact_name, company_name, phone, first_name, 
last_name, title, order_date, product_name, ship_country, products.unit_price, quantity, discount
FROM orders
JOIN order_details USING(order_id)
JOIN products USING(product_id)
JOIN customers USING(customer_id)
JOIN employees USING(employee_id)
WHERE ship_country = 'USA';

SELECT order_id, customer_id, first_name, last_name, title
FROM orders
NATURAL JOIN employees;