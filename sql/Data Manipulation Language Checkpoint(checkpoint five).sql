CREATE DATABASE sims
USE sims

-- Create customers table
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY NOT NULL,
    name VARCHAR(10) NOT NULL,
    address VARCHAR(100) NOT NULL
);


--inserting data into  customers
INSERT INTO customers(customer_id,name,address)
VALUES(1,'Ahmed','Tunisia'),
	  (2,'Coulibaly','Senegal'),
	  (3,'Hasan','Egypt');

	  SELECT * FROM customers

-- deleting data from customer's table
DELETE FROM customers
WHERE customer_id = 3;


-- Create products table
CREATE TABLE products (
    product_id INTEGER PRIMARY KEY NOT NULL,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) CHECK (price > 0) NOT NULL
);

--inserting data into  products
INSERT INTO products(product_id,name,price)
VALUES(1,'Cookies',10.00),
	  (2,'Candy',5.20);

	  SELECT * FROM Products


-- Create orders table
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY NOT NULL,
    customer_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

--inserting data into  orders
INSERT INTO orders(order_id,customer_id,product_id,quantity,order_date)
VALUES(1,1,2,3,'2023-01-22'),
	  (2,2,1,10,'2023-04-14');

-- updating data in order's table
UPDATE orders
SET quantity = 6
WHERE order_id = 2;

-- deleting data from order's table
DELETE FROM orders;

--Dropping orders table
DROP TABLE orders;