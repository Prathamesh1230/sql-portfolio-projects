create database car_sales_analysis;

use car_sales_analysis;

-- 1. Overall Dataset Overview
SELECT 
    COUNT(*) AS total_records,
    COUNT(DISTINCT Manufacturer) AS unique_manufacturers,
    COUNT(DISTINCT Model) AS unique_models,
    COUNT(DISTINCT Vehicle_type) AS unique_vehicle_types
FROM car_sales;

-- 2. Top 10 Best-Selling Cars (by Sales)
SELECT Manufacturer, Model, Sales_in_thousands
FROM car_sales
ORDER BY Sales_in_thousands DESC
LIMIT 10;

-- 3. Total Sales by Manufacturer
SELECT Manufacturer,
    SUM(Sales_in_thousands) AS total_sales,
    AVG(Sales_in_thousands) AS avg_sales_per_model,
    COUNT(*) AS models_count
FROM car_sales
GROUP BY Manufacturer
ORDER BY total_sales DESC;

-- 4. Price Distribution Stats
SELECT
    MIN(Price_in_thousands) AS min_price,
    MAX(Price_in_thousands) AS max_price,
    AVG(Price_in_thousands) AS avg_price
FROM car_sales;

-- 5. Latest Models Launched 
SELECT Manufacturer, Model, Latest_Launch
FROM car_sales
ORDER BY Latest_Launch DESC
LIMIT 10;

-- 6. Engine Size vs. Fuel Efficiency Relationship
SELECT Engine_size,
    ROUND(AVG(Fuel_efficiency), 2) AS avg_fuel_efficiency,
    COUNT(*) AS car_count
FROM car_sales
GROUP BY Engine_size
ORDER BY Engine_size;

-- 7. Sales vs. Price Correlation
SELECT Manufacturer, Model, Price_in_thousands, Sales_in_thousands,
    CASE 
        WHEN Price_in_thousands < 15 THEN 'Budget'
        WHEN Price_in_thousands < 30 THEN 'Mid-range'
        ELSE 'Premium'
    END AS price_category
FROM car_sales
ORDER BY Sales_in_thousands DESC;

-- 8. Manufacturer with Highest Average Horsepower per Model
SELECT Manufacturer,
    ROUND(AVG(Horsepower), 2) AS avg_horsepower
FROM car_sales
GROUP BY Manufacturer
HAVING COUNT(*) > 2
ORDER BY avg_horsepower DESC;

-- 9. Market Segmentation: Vehicle Price vs. Sales Performance
SELECT
  CASE
    WHEN Price_in_thousands < 20 THEN 'Low'
    WHEN Price_in_thousands BETWEEN 20 AND 40 THEN 'Mid'
    ELSE 'High'
  END AS price_segment,
  COUNT(*) AS model_count,
  ROUND(AVG(Sales_in_thousands),2) AS avg_sales
FROM car_sales
GROUP BY price_segment;
