SELECT DISTINCT employee_id, total_by_emp, AVG(total_by_emp) OVER() AS avg_price
FROM
	(
	SELECT employee_id, SUM(unit_price*quantity) OVER(PARTITION BY employee_id) AS total_by_emp
	FROM orders
	LEFT JOIN order_details USING(order_id)
		) q
ORDER BY total_by_emp DESC;

SELECT last_name, first_name, title, salary, DENSE_RANK() OVER(ORDER BY salary DESC)
FROM employees