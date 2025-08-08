-- ==========================
--  NETFLIX SQL PROJECT
--  PostgreSQL Compatible
-- ==========================

-- 1️⃣ Drop table if exists
DROP TABLE IF EXISTS netflix;

-- 2️⃣ Create table
CREATE TABLE netflix (
    show_id       VARCHAR(6) PRIMARY KEY,
    type          VARCHAR(10),
    title         VARCHAR(255),
    director      VARCHAR(255),
    casts         VARCHAR(1000),
    country       VARCHAR(150),
    date_added    VARCHAR(150),
    release_year  INT,
    rating        VARCHAR(10),
    duration      VARCHAR(20),
    listed_in     VARCHAR(150),
    description   VARCHAR(250)
);

-- View all data
SELECT * FROM netflix;


-- ==========================
-- BASIC EXPLORATION
-- ==========================

-- Total content
SELECT COUNT(*) AS total_content
FROM netflix;

-- Distinct content types
SELECT DISTINCT type
FROM netflix;


-- ==========================
-- BUSINESS PROBLEMS
-- ==========================

-- 1️⃣ Count the number of Movies vs TV Shows
SELECT type, COUNT(*) AS total_content
FROM netflix
GROUP BY type;

-- 2️⃣ Most common rating for each type
SELECT type, rating
FROM (
    SELECT 
        type,
        rating,
        COUNT(*) AS cnt,
        RANK() OVER (PARTITION BY type ORDER BY COUNT(*) DESC) AS ranking
    FROM netflix
    GROUP BY type, rating
) AS t1
WHERE ranking = 1;

-- 3️⃣ All Movies released before 2020
SELECT *
FROM netflix
WHERE release_year < 2020
  AND type = 'Movie';

-- 4️⃣ Top 5 countries with most content
SELECT 
    TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) AS new_country,
    COUNT(show_id) AS total_content
FROM netflix
GROUP BY new_country
ORDER BY total_content DESC
LIMIT 5;

-- 5️⃣ Longest Movie
SELECT *
FROM netflix
WHERE type = 'Movie'
  AND duration = (SELECT MAX(duration) FROM netflix WHERE type = 'Movie');

-- 6️⃣ Movies added in the last 5 years
SELECT *
FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years'
ORDER BY TO_DATE(date_added, 'Month DD, YYYY') DESC;

-- 7️⃣ All TV Shows by a specific director (Example: Rajiv Chilaka)
SELECT *
FROM netflix
WHERE director ILIKE '%Rajiv Chilaka%';

-- 8️⃣ TV Shows with more than 5 seasons
SELECT * 
FROM netflix 
WHERE type = 'TV Show'
  AND CAST(SPLIT_PART(duration, ' ', 1) AS INTEGER) > 5;

-- 9️⃣ Content uploaded by India each year
SELECT 
    EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) AS year,
    COUNT(*) AS total_content
FROM netflix
WHERE country ILIKE '%India%'
  AND date_added IS NOT NULL
GROUP BY year
ORDER BY year;

-- 🔟 All Movies that are Documentaries
SELECT *
FROM netflix
WHERE listed_in ILIKE '%Documentaries%';

-- 1️⃣1️⃣ Find the N-th ranked rating (Example: N = 5)
WITH ranked_titles AS (
    SELECT 
        title,
        rating,
        RANK() OVER (ORDER BY rating DESC) AS rnk
    FROM netflix
)
SELECT *
FROM ranked_titles
WHERE rnk = 5;  -- Change 5 to your desired rank
