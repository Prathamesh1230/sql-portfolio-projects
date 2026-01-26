DROP DATABASE IF EXISTS e_commerce_database;
CREATE DATABASE e_commerce_database;
USE e_commerce_database;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    location VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    income_group VARCHAR(50),
    loyalty_score INT
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    transaction_id INT PRIMARY KEY,
    transaction_date DATE,
    payment_method VARCHAR(50),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_id INT,
    product_id INT,
    quantity INT,
    discount DECIMAL(5,2),
    FOREIGN KEY (transaction_id) REFERENCES orders(transaction_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
