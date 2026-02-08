create database video_game_sales;
use video_game_sales;

ALTER table video_games_sales
rename column `ï»¿Rank` to `Rank`;

-- Total number of games in the dataset
SELECT COUNT(*) AS total_games
FROM video_games_sales;

-- Check missing values in important columns
SELECT 
    SUM(CASE WHEN Name IS NULL THEN 1 ELSE 0 END) AS null_names,
    SUM(CASE WHEN Year IS NULL THEN 1 ELSE 0 END) AS null_years,
    SUM(CASE WHEN Genre IS NULL THEN 1 ELSE 0 END) AS null_genres,
    SUM(CASE WHEN Publisher IS NULL THEN 1 ELSE 0 END) AS null_publishers
FROM video_games_sales;

-- Total sales by region
SELECT 
    ROUND(SUM(NA_Sales), 2) AS north_america_sales,
    ROUND(SUM(EU_Sales), 2) AS europe_sales,
    ROUND(SUM(JP_Sales), 2) AS japan_sales,
    ROUND(SUM(Other_Sales), 2) AS other_regions_sales,
    ROUND(SUM(Global_Sales), 2) AS global_sales
FROM video_games_sales;

-- Games released per platform
SELECT 
    Platform,
    COUNT(*) AS total_games
FROM video_games_sales
GROUP BY Platform
ORDER BY total_games DESC;

-- Find the highest selling games of all time
SELECT 
    `Rank`,
    Name,
    Platform,
    Year,
    Genre,
    Publisher,
    Global_Sales
FROM video_games_sales
ORDER BY Global_Sales DESC
LIMIT 10;

-- Which game genres sell the most?
SELECT 
    Genre,
    COUNT(*) AS game_count,
    ROUND(SUM(Global_Sales), 2) AS total_sales,
    ROUND(AVG(Global_Sales), 2) AS avg_sales_per_game
FROM video_games_sales
GROUP BY Genre
ORDER BY total_sales DESC;

-- Compare sales across different gaming platforms
SELECT 
    Platform,
    COUNT(*) AS game_count,
    ROUND(SUM(Global_Sales), 2) AS total_sales,
    ROUND(AVG(Global_Sales), 2) AS avg_sales_per_game
FROM video_games_sales
GROUP BY Platform
ORDER BY total_sales DESC
LIMIT 15;

-- Which publishers have the most success?
SELECT 
    Publisher,
    COUNT(*) AS game_count,
    ROUND(SUM(Global_Sales), 2) AS total_sales,
    ROUND(AVG(Global_Sales), 2) AS avg_sales_per_game
FROM video_games_sales
GROUP BY Publisher
ORDER BY total_sales DESC
LIMIT 10;

-- Analyze sales trends over the years
SELECT 
    Year,
    COUNT(*) AS games_released,
    ROUND(SUM(Global_Sales), 2) AS total_sales,
    ROUND(AVG(Global_Sales), 2) AS avg_sales
FROM video_games_sales
WHERE Year IS NOT NULL
GROUP BY Year
ORDER BY Year DESC;

-- Compare gaming industry growth year by year
SELECT 
    Year,
    COUNT(*) AS games_released,
    ROUND(SUM(Global_Sales), 2) AS total_sales,
    ROUND(AVG(Global_Sales), 2) AS avg_sales
FROM video_games_sales
WHERE Year IS NOT NULL AND Year >= 1995
GROUP BY Year
ORDER BY Year;

-- Calculate market share for top publishers
SELECT 
    Publisher,
    COUNT(*) AS game_count,
    ROUND(SUM(Global_Sales), 2) AS total_sales,
    ROUND(
        SUM(Global_Sales) / (SELECT SUM(Global_Sales) FROM video_games_sales) * 100, 
        2
    ) AS market_share_percentage,
    ROUND(AVG(Global_Sales), 2) AS avg_sales_per_game
FROM video_games_sales
GROUP BY Publisher
HAVING SUM(Global_Sales) > 50
ORDER BY total_sales DESC
LIMIT 15;