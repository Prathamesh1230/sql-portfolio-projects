create database restaurant_analysis;

use restaurant_analysis;

-- 1. View all restaurant records
SELECT * FROM swiggy;

-- 2. Count total number of restaurants
SELECT COUNT(*) AS total_restaurants FROM swiggy;

-- 3. Find average price across all restaurants
SELECT ROUND(AVG(Price), 2) AS avg_price FROM swiggy;

-- 4. List restaurants with average rating greater than 4.5
SELECT Restaurant, City, `Avg ratings` FROM swiggy
WHERE `Avg ratings` > 4.5
ORDER BY `Avg ratings` DESC;

-- 5. Show unique food types offered
SELECT DISTINCT `Food type` FROM swiggy;

-- 6. Top 5 most expensive restaurants
SELECT Restaurant, City, Price FROM swiggy
ORDER BY Price DESC
LIMIT 5;

-- 7. Average delivery time by city
SELECT City, ROUND(AVG(`Delivery time`), 2) AS avg_delivery_time
FROM swiggy
GROUP BY City
ORDER BY avg_delivery_time;

-- 8. Which area has the highest number of restaurants
SELECT Area, COUNT(*) AS num_restaurants
FROM swiggy
GROUP BY Area
ORDER BY num_restaurants DESC
LIMIT 1;

-- 9. Most popular food types by total ratings
SELECT `Food type`, SUM(`Total ratings`) AS total_ratings
FROM swiggy
GROUP BY `Food type`
ORDER BY total_ratings DESC
LIMIT 5;

-- 10. Restaurant(s) with the fastest delivery time in each city
SELECT City, Restaurant, `Delivery time`
FROM swiggy s1
WHERE `Delivery time` = (
    SELECT MIN(`Delivery time`) FROM swiggy s2 WHERE s2.City = s1.City
);
