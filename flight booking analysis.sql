create database Flight_booking_analysis;
use Flight_booking_analysis;

ALTER TABLE flight
CHANGE COLUMN `ï»¿Sr no.` sr_no INT;

-- 1. View all data
SELECT * FROM flight;

-- 2. Filter passengers older than 40
SELECT * 
FROM flight
WHERE Age > 40;

-- 3. Sort by age (descending)
SELECT id, Age
FROM flight
ORDER BY Age DESC;

-- 4. Find average flight distance
SELECT AVG(`Flight Distance`) AS avg_distance
FROM flight;

-- 5. Count passengers by gender
SELECT Gender, COUNT(*) AS total
FROM flight
GROUP BY Gender;

-- 6. Average age per customer type
SELECT `Customer Type`, AVG(Age) AS avg_age
FROM flight
GROUP BY `Customer Type`;

-- 7. Top 10 longest flights
SELECT id, `Flight Distance`
FROM flight
ORDER BY `Flight Distance` DESC
LIMIT 10;

-- 8. Average delay by travel type
SELECT `Type of Travel`,
       AVG(`Departure Delay in Minutes`) AS avg_departure_delay,
       AVG(`Arrival Delay in Minutes`) AS avg_arrival_delay
FROM flight
GROUP BY `Type of Travel`;

-- 9. Rank Longest Flights
SELECT id, `Flight Distance`,
RANK() OVER (ORDER BY `Flight Distance` DESC) AS distance_rank
FROM flight;

-- 10. Most Delayed Passengers
SELECT id, (`Departure Delay in Minutes` + `Arrival Delay in Minutes`) AS total_delay
FROM flight
ORDER BY total_delay DESC
LIMIT 5;

-- 11. Passengers With Above-Average Delay Within Their Class
SELECT * FROM (SELECT id, Class, (`Departure Delay in Minutes` + `Arrival Delay in Minutes`) AS total_delay,
AVG(`Departure Delay in Minutes` + `Arrival Delay in Minutes`) 
OVER (PARTITION BY Class) AS class_avg_delay
FROM flight) AS delay_data
WHERE total_delay > class_avg_delay;


