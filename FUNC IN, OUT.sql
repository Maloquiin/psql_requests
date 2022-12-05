CREATE OR REPLACE FUNCTION get_product_price_by_name(prod_name varchar) RETURNS real AS $$
	SELECT unit_price
	FROM products
	WHERE product_name = prod_name
$$ LANGUAGE SQL;

SELECT get_product_price_by_name('Chocolade') AS price;

CREATE OR REPLACE FUNCTION get_price_boundaries(OUT max_price real, OUT min_price real) AS $$
	
	SELECT MAX(unit_price), MIN(unit_price)
	FROM products

$$ LANGUAGE SQL;

SELECT get_price_boundaries();
SELECT * FROM get_price_boundaries();

CREATE OR REPLACE FUNCTION get_price_boudaries_by_discontinuity(IN is_discontinued int DEFAULT 1,
																OUT max_price real, 
																OUT min_price real) AS $$
	SELECT MAX(unit_price), MIN(unit_price)
	FROM products
	WHERE discontinued = is_discontinued

$$ LANGUAGE SQL;

SELECT * FROM get_price_boudaries_by_discontinuity();