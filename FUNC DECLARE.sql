CREATE FUNCTION get_square(ab real, bc real, ac real) RETURNS real AS $$
DECLARE
	perimeter real;

BEGIN
	perimeter = (ab+ bc + ac) / 2;
	RETURN sqrt(perimeter * (perimeter - ab) * (perimeter - bc) * (perimeter - ac));
END;
$$ LANGUAGE plpgsql;

SELECT get_square(6,6,6);

CREATE FUNCTION calc_middle_price() RETURNS SETOF products AS $$
DECLARE
	avg_price real;
	low_price real;
	high_price real;
BEGIN
	SELECT AVG(unit_price) INTO avg_price
	FROM products;
	
	low_price = avg_price * 0.75;
	high_price = avg_price * 1.25;
	
	RETURN QUERY
	SELECT * FROM products
	WHERE unit_price BETWEEN low_price AND high_price;

END;
$$ LANGUAGE plpgsql;

SELECT * FROM calc_middle_price();