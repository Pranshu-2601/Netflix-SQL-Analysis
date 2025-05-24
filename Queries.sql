-- 1. Count total records
SELECT COUNT(*) AS total_titles FROM netflixdata;

-- 2. Get distinct types of content
SELECT DISTINCT type FROM netflixdata;

-- 3. Get top 10 recent titles added
SELECT title, date_added
FROM netflixdata
ORDER BY date_added DESC
LIMIT 10;

-- 4. Count of movies vs TV shows
SELECT type, COUNT(*) AS count
FROM netflixdata
GROUP BY type;

-- 5. Get all titles released in 2018
SELECT title, release_year
FROM netflixdata
WHERE release_year = 2018;

-- 6. Top 5 countries with most content
SELECT 
    COALESCE(NULLIF(country, ''), 'Unknown') AS country,
    COUNT(*) AS count
FROM netflixdata
GROUP BY COALESCE(NULLIF(country, ''), 'Unknown')
ORDER BY count DESC
LIMIT 5;


-- 7. Most frequent directors (ignoring NULL)
SELECT director, COUNT(director) AS count
FROM netflixdata
WHERE director IS NOT NULL
GROUP BY director
ORDER BY count DESC
LIMIT 10;

-- 8. Titles by rating
SELECT 
    COALESCE(NULLIF(rating, ''), 'Unknown') AS rating,
    COUNT(*) AS count
FROM netflixdata
GROUP BY COALESCE(NULLIF(rating, ''), 'Unknown')
ORDER BY count DESC;


-- 9. Genre frequency (exploding listed_in)
SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(listed_in, ',', n.n), ',', -1)) AS genre,
       COUNT(*) AS count
FROM netflixdata
JOIN (
    SELECT a.N + b.N * 10 + 1 n
    FROM 
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
         UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
        (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
         UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b
) n
ON CHAR_LENGTH(listed_in) -CHAR_LENGTH(REPLACE(listed_in, ',', '')) >= n.n - 1
GROUP BY genre
ORDER BY count DESC
LIMIT 10;

-- 10. Duration format breakdown (e.g., movies vs episodes)
SELECT 
    CASE 
        WHEN duration LIKE '%Season%' THEN 'TV Show'
        WHEN duration LIKE '%min%' THEN 'Movie'
        ELSE 'Other'
    END AS content_type,
    COUNT(*) AS count
FROM netflixdata
GROUP BY content_type;

-- 11. Longest movie titles (by duration)
SELECT title, duration
FROM netflixdata
WHERE duration LIKE '%min%'
ORDER BY CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) DESC
LIMIT 10;

-- 12. Directors who worked across multiple genres
-- (basic multi-genre count based on director)
SELECT director, COUNT(DISTINCT listed_in) AS unique_genres
FROM netflixdata
WHERE director IS NOT NULL
GROUP BY director
ORDER BY unique_genres DESC
LIMIT 10;

-- 13. Simulated recommendation: Similar genres
SELECT *
FROM netflixdata
WHERE listed_in LIKE '%Action%' AND release_year > 2015
ORDER BY date_added DESC
LIMIT 10;

-- 14. Titles where description mentions "Love", "War", or "Life"
SELECT 
    title, 
    type, 
    release_year, 
    description
FROM netflixdata
WHERE description REGEXP '\\b(Love|War|Life)\\b'
ORDER BY release_year DESC;

-- 15. Top countries producing "Drama" content
SELECT 
    country, 
    COUNT(*) AS drama_count
FROM netflixdata
WHERE listed_in LIKE '%Drama%'
	AND country IS NOT NULL
GROUP BY country
ORDER BY drama_count DESC
LIMIT 10;



