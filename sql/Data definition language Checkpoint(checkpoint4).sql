
CREATE DATABASE Checkpoint_2
USE Checkpoint_2

-- Create customers table
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY NOT NULL,
    name VARCHAR(10) NOT NULL,
    address VARCHAR(100) NOT NULL
);

	  SELECT * FROM customers



-- Create products table
CREATE TABLE Products (
    product_id INTEGER PRIMARY KEY NOT NULL,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) CHECK (price > 0) NOT NULL
);

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

