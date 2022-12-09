SELECT employee_id, SUM(unit_price*quantity)
FROM orders
LEFT JOIN order_details USING(order_id)
GROUP BY ROLLUP(employee_id)
ORDER BY SUM(unit_price*quantity) DESC;


SELECT employee_id ,ship_country, SUM(unit_price*quantity)
FROM orders
LEFT JOIN order_details USING(order_id)
GROUP BY ROLLUP(employee_id, ship_country)
ORDER BY employee_id, SUM(unit_price*quantity) DESC;

SELECT employee_id ,ship_country, SUM(unit_price*quantity)
FROM orders
LEFT JOIN order_details USING(order_id)
GROUP BY CUBE(employee_id, ship_country)
ORDER BY employee_id, SUM(unit_price*quantity) DESC;