SELECT category_id AS category, SUM(unit_price * units_in_stock) AS Summa
FROM products
WHERE discontinued <> 1
GROUP BY category_id
HAVING SUM(unit_price * units_in_stock) > 5000
ORDER BY SUM(unit_price * units_in_stock)