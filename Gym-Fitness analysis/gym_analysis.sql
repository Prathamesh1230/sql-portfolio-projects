create database gym_analysis;
use gym_analysis;

ALTER table gym_members_exercise
rename column ï»¿Age to Age;

ALTER table gym_members_exercise
rename column `Workout_Frequency_days/week` to Workout_Frequency_days_week;

-- Check total number of records
SELECT COUNT(*) AS total_members
FROM gym_members_exercise;

-- View first 10 records
SELECT *
FROM gym_members_exercise
LIMIT 10;

-- Gender distribution
SELECT 
    Gender,
    COUNT(*) AS member_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM gym_members_exercise), 2) AS percentage
FROM gym_members_exercise
GROUP BY Gender;

-- Experience level distribution
SELECT 
    Experience_Level,
    COUNT(*) AS member_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM gym_members_exercise), 2) AS percentage,
    ROUND(AVG(Age), 1) AS avg_age
FROM gym_members_exercise
GROUP BY Experience_Level
ORDER BY Experience_Level;

-- Age distribution by ranges
SELECT 
    CASE 
        WHEN Age < 25 THEN '18-24'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS age_group,
    COUNT(*) AS member_count,
    ROUND(AVG(BMI), 2) AS avg_bmi,
    ROUND(AVG(Fat_Percentage), 2) AS avg_fat_percentage
FROM gym_members_exercise
GROUP BY age_group
ORDER BY age_group;

-- Find most popular workout types
SELECT 
    Workout_Type,
    COUNT(*) AS member_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM gym_members_exercise), 2) AS percentage,
    ROUND(AVG(Calories_Burned), 2) AS avg_calories_burned
FROM gym_members_exercise
GROUP BY Workout_Type
ORDER BY member_count DESC;

-- Find the top performing members
SELECT 
    Age,
    Gender,
    Workout_Type,
    Calories_Burned,
    Session_Duration_hours,
    Workout_Frequency_days_week,
    Experience_Level
FROM gym_members_exercise
ORDER BY Calories_Burned DESC
LIMIT 10;

-- See how often members work out per week
SELECT 
    Workout_Frequency_days_week AS days_per_week,
    COUNT(*) AS member_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM gym_members_exercise), 2) AS percentage,
    ROUND(AVG(Calories_Burned), 2) AS avg_calories
FROM gym_members_exercise
GROUP BY Workout_Frequency_days_week
ORDER BY Workout_Frequency_days_week;

-- Analyze members by their fitness experience
SELECT 
    Experience_Level,
    COUNT(*) AS member_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM gym_members_exercise), 2) AS percentage,
    ROUND(AVG(Age), 1) AS avg_age,
    ROUND(AVG(Calories_Burned), 2) AS avg_calories,
    ROUND(AVG(Workout_Frequency_days_week), 1) AS avg_weekly_workouts
FROM gym_members_exercise
GROUP BY Experience_Level
ORDER BY Experience_Level;