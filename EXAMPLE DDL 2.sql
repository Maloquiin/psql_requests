ALTER TABLE products
ADD CONSTRAINT CHK_products_unit_price CHECK (unit_price > 0);

SELECT MAX(product_id)
FROM products;


CREATE SEQUENCE IF NOT EXISTS products_product_id_seq
START WITH 78 OWNED BY products.product_id;

ALTER TABLE products
ALTER COLUMN product_id SET DEFAULT nextval('products_products_id_seq');


INSERT INTO products (product_name, discontinued)
VALUES ('Test name', 1)
RETURNING *;