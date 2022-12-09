CREATE OR REPLACE FUNCTION filter_even(VARIADIC numbers int[]) RETURNS SETOF int AS $$
DECLARE
	counter int;
BEGIN
	--FOR counter IN 1..array_upper(numbers, 1)
	FOREACH counter IN ARRAY numbers
	LOOP
		CONTINUE WHEN counter % 2 != 0;
		RETURN NEXT counter;
	END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM filter_even(1, 2, 3, 4, 5, 6, 7, 8);

SELECT AVG(freight) 
FROM orders 
WHERE ship_country = 'USA';


CREATE OR REPLACE FUNCTION get_avg_freight_by_array_country(VARIADIC ar_country text[]) RETURNS SETOF float8 AS $$
DECLARE
	counter text;
	avg_freight float8;
BEGIN
	FOREACH counter in ARRAY ar_country
	LOOP
	SELECT AVG(freight) FROM orders 
	WHERE ship_country = counter INTO avg_freight;
	RETURN NEXT avg_freight;
	
	END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT get_avg_freight_by_array_country('USA','Canada');

DROP FUNCTION filter_phones;
CREATE OR REPLACE FUNCTION filter_phones2(code_operator int, VARIADIC phones text[]) RETURNS SETOF text AS $$

DECLARE
	counter text;
BEGIN
	FOREACH counter in ARRAY phones
	LOOP
	IF counter ~ code_operator::text THEN RETURN NEXT counter;
	--IF counter NOT LIKE CONCAT('__(', code_operator, ')%');
	END IF;
	END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT filter_phones2(903,'+7(903)1901235','+7(926)8567589','+7(903)1532476');

