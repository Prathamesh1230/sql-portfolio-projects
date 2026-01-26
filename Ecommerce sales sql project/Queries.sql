-- 1. Total Revenue
SELECT 
    ROUND(SUM(oi.quantity * p.price * (1 - oi.discount)), 2) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;

-- 2. Revenue by Product Category
SELECT 
    p.category,
    ROUND(SUM(oi.quantity * p.price * (1 - oi.discount)), 2) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;

-- 3. Top 10 Best-Selling Products
SELECT 
    p.product_id,
    p.category,
    SUM(oi.quantity) AS total_units_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.category
ORDER BY total_units_sold DESC
LIMIT 10;

-- 4. Top 10 Customers by Spend
SELECT 
    c.customer_id,
    c.location,
    ROUND(SUM(oi.quantity * p.price * (1 - oi.discount)), 2) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.transaction_id = oi.transaction_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.location
ORDER BY total_spent DESC
LIMIT 10;

-- 5. Payment Method Usage
SELECT 
    payment_method,
    COUNT(*) AS total_transactions
FROM orders
GROUP BY payment_method
ORDER BY total_transactions DESC;

-- 6. Average Order Value
SELECT 
    ROUND(SUM(oi.quantity * p.price * (1 - oi.discount)) / COUNT(DISTINCT o.transaction_id), 2)
    AS avg_order_value
FROM orders o
JOIN order_items oi ON o.transaction_id = oi.transaction_id
JOIN products p ON oi.product_id = p.product_id;

-- 7. City-wise Revenue
SELECT 
    c.location,
    ROUND(SUM(oi.quantity * p.price * (1 - oi.discount)), 2) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.transaction_id = oi.transaction_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.location
ORDER BY revenue DESC;
