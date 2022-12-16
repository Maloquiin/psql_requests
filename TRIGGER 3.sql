ALTER TABLE products
ADD COLUMN last_updated timestamp;

CREATE OR REPLACE FUNCTION track_changes_on_products() RETURNS trigger AS $$
BEGIN
	NEW.last_updated = now();
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS products_timestamp ON products;

CREATE TRIGGER products_timestamp BEFORE INSERT OR UPDATE ON products
	FOR EACH ROW EXECUTE PROCEDURE track_changes_on_products();
	
SELECT * FROM products;
	
UPDATE products
SET units_in_stock = 42
WHERE product_id = 1;


--


DROP TABLE IF EXISTS order_details_audit;

CREATE TABLE order_details_audit
(
	op char(1) NOT NULL,
	user_changed text NOT NULL,
	time_stamp timestamp NOT NULL,
	order_id smallint NOT NULL,
	product_id smallint NOT NULL,
	unit_price real NOT NULL,
	quantity smallint NOT NULL,
	discount real NOT NULL
);


CREATE OR REPLACE FUNCTION build_audit_order_details() RETURNS TRIGGER AS $$
BEGIN
	IF TG_OP = 'INSERT' THEN
		INSERT INTO order_details_audit
		SELECT 'I', session_user, now(), nt.* FROM new_table nt;
	ELSEIF TG_OP = 'UPDATE' THEN 
		INSERT INTO order_details_audit
		SELECT 'U', session_user, now(), nt.* FROM new_table nt;
	ELSEIF TG_OP = 'DELETE' THEN 
		INSERT INTO order_details_audit
		SELECT 'D', session_user, now(), ot.* FROM old_table ot;
	END IF;
	RETURN NULL;
END
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS audit_order_details_insert ON order_details;
CREATE TRIGGER audit_order_details_insert AFTER INSERT ON order_details
REFERENCING NEW TABLE AS new_table
FOR EACH STATEMENT EXECUTE PROCEDURE build_audit_order_details();

DROP TRIGGER IF EXISTS audit_order_details_update ON order_details;
CREATE TRIGGER audit_order_details_update AFTER UPDATE ON order_details
REFERENCING NEW TABLE AS new_table
FOR EACH STATEMENT EXECUTE PROCEDURE build_audit_order_details();

DROP TRIGGER IF EXISTS audit_order_details_delete ON order_details;
CREATE TRIGGER audit_order_details_delete AFTER DELETE ON order_details
REFERENCING OLD TABLE AS old_table
FOR EACH STATEMENT EXECUTE PROCEDURE build_audit_order_details();

SELECT * FROM order_details;
SELECT * FROM orders;
SELECT * FROM order_details_audit;

INSERT INTO order_details
VALUES (10248,10,80,40,9999)