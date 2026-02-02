create database movie_database_analysis;
use movie_database_analysis;

SHOW COLUMNS FROM imdb_movies;

ALTER TABLE imdb_movies 
CHANGE `ï»¿Poster_Link` poster_link TEXT;

-- Check total number of movies
SELECT COUNT(*) AS total_movies FROM imdb_movies;

-- Preview data
SELECT * FROM imdb_movies LIMIT 10;

-- Top 10 Highest-Rated Movies
SELECT 
    Series_Title,
    Released_Year,
    IMDB_Rating,
    Genre,
    Director,
    No_of_Votes
FROM imdb_movies
ORDER BY IMDB_Rating DESC, No_of_Votes DESC
LIMIT 10;

-- Genre Distribution
SELECT 
    Genre,
    COUNT(*) AS movie_count,
    ROUND(AVG(IMDB_Rating), 2) AS avg_rating,
    ROUND(AVG(Gross), 2) AS avg_gross
FROM imdb_movies
GROUP BY Genre
ORDER BY movie_count DESC
LIMIT 15;

-- Top 10 Most Voted Movies
SELECT 
    Series_Title,
    Released_Year,
    IMDB_Rating,
    Genre,
    Director,
    No_of_Votes
FROM imdb_movies
ORDER BY No_of_Votes DESC
LIMIT 10;

-- Movies by Decade
SELECT 
    CONCAT(FLOOR(Released_Year / 10) * 10, 's') AS decade,
    COUNT(*) AS movie_count,
    ROUND(AVG(IMDB_Rating), 2) AS avg_rating,
    ROUND(AVG(Meta_score), 2) AS avg_meta_score
FROM imdb_movies
WHERE Released_Year IS NOT NULL
GROUP BY decade
ORDER BY decade DESC;

-- Top 10 Highest-Grossing Movies
SELECT 
    Series_Title,
    Released_Year,
    Director,
    Genre,
    IMDB_Rating,
    Gross AS box_office_gross,
    No_of_Votes
FROM imdb_movies
WHERE Gross IS NOT NULL
ORDER BY Gross DESC
LIMIT 10;

-- Top 10 Directors by Average Rating
SELECT 
    Director,
    COUNT(*) AS total_movies,
    ROUND(AVG(IMDB_Rating), 2) AS avg_rating,
    ROUND(AVG(Meta_score), 2) AS avg_meta_score,
    SUM(No_of_Votes) AS total_votes
FROM imdb_movies
WHERE Director IS NOT NULL
GROUP BY Director
HAVING total_movies >= 3
ORDER BY avg_rating DESC, total_movies DESC
LIMIT 10;

-- Most Popular Actors (Based on Star1 appearances)
SELECT 
    Star1 AS actor_name,
    COUNT(*) AS movie_count,
    ROUND(AVG(IMDB_Rating), 2) AS avg_movie_rating,
    ROUND(AVG(Gross), 2) AS avg_gross,
    SUM(No_of_Votes) AS total_votes
FROM imdb_movies
WHERE Star1 IS NOT NULL AND Star1 != ''
GROUP BY Star1
ORDER BY movie_count DESC, avg_movie_rating DESC
LIMIT 15;

-- Top Profitable Movies (Revenue per Vote Analysis)
SELECT 
    Series_Title,
    Released_Year,
    Director,
    Genre,
    IMDB_Rating,
    No_of_Votes,
    Gross,
    ROUND(Gross / No_of_Votes, 2) AS revenue_per_vote,
    Certificate
FROM imdb_movies
WHERE Gross IS NOT NULL 
  AND No_of_Votes IS NOT NULL 
  AND No_of_Votes > 0
ORDER BY revenue_per_vote DESC
LIMIT 20;


