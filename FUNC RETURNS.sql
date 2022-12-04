CREATE OR REPLACE FUNCTION get_total_number_of_goods() RETURNS bigint AS $$
	SELECT SUM(units_in_stock)
	FROM products
$$ LANGUAGE SQL;

SELECT get_total_number_of_goods() AS total_goods;

CREATE OR REPLACE FUNCTION get_avg_price() RETURNS real AS $$
	SELECT AVG(unit_price)
	FROM products
$$ LANGUAGE SQL;

SELECT get_avg_price() AS avg_price;