USE e_commerce_database;

SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE order_items;
TRUNCATE TABLE orders;
TRUNCATE TABLE products;
TRUNCATE TABLE customers;

SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO customers (customer_id, location, age, gender, income_group, loyalty_score)
SELECT
    CustomerID,
    MAX(CustomerLocation),
    MAX(CustomerAge),
    MAX(CustomerGender),
    MAX(CustomerIncomeGroup),
    MAX(CustomerLoyaltyScore)
FROM ecommerce_sales_data
GROUP BY CustomerID;

INSERT INTO products (product_id, category, price)
SELECT
    ProductID,
    MAX(ProductCategory),
    MAX(Price)
FROM ecommerce_sales_data
GROUP BY ProductID;

USE e_commerce_database;

SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE order_items;
TRUNCATE TABLE orders;

SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO orders (transaction_id, transaction_date, payment_method, customer_id)
SELECT DISTINCT
    e.TransactionID,
    e.TransactionDate,
    e.PaymentMethod,
    e.CustomerID
FROM ecommerce_sales_data e
JOIN customers c
  ON e.CustomerID = c.customer_id;

INSERT INTO order_items (transaction_id, product_id, quantity, discount)
SELECT
    e.TransactionID,
    e.ProductID,
    e.Quantity,
    e.Discount
FROM ecommerce_sales_data e
JOIN orders o
  ON e.TransactionID = o.transaction_id;

-- Verify
SELECT COUNT(*) AS customers_count FROM customers;
SELECT COUNT(*) AS products_count FROM products;
SELECT COUNT(*) AS orders_count FROM orders;
SELECT COUNT(*) AS order_items_count FROM order_items;







