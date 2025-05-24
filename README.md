![CoverImg](https://github.com/user-attachments/assets/a376ebcd-e26e-44a6-a7fe-76533b7d0070)
# 🎬 Netflix Titles SQL Project
This project is a comprehensive SQL-based analysis of the **Netflix Titles Dataset**, which contains metadata on all movies and TV shows available on Netflix up to mid-2021. The goal is to demonstrate SQL querying skills, data exploration techniques, and data-driven insights using a real-world dataset.

## 🛠 Data Import Process (CSV)
The Netflix Titles dataset was successfully imported into **MySQL** using the built-in CSV import functionality in **MySQL Workbench**. The import process auto-generated the schema based on the CSV structure and resolved previous encoding issues by setting the proper character set.

### ✅ Steps Followed:
1. Open **MySQL Workbench** and Create database using command: <pre> ```CREATE DATABASE Netflix; ``` </pre>
2. Use the database with the command: <pre> ```USE Netflix; ``` </pre>
3. Right-click on **Database Created** → Select **Table Data Import Wizard**.
![Screenshot 2025-05-24 at 15 50 32](https://github.com/user-attachments/assets/9b07f3b9-a168-4667-be36-175cb12df5de)
4. Choose the CSV file: `netflix_titles.csv`.
5. In the wizard, review and confirm column mappings.
6. Make sure to set encoding to `UTF-8` (important for special characters).
![Screenshot 2025-05-24 at 17 52 43](https://github.com/user-attachments/assets/c9d95801-e475-404d-812f-76cd38a34029)
7. Click **Next** to complete the import.

### 📌 Notes:
- If you encounter issues with `date_added`, ensure the date format in CSV is consistent.
- Recommended table name: `netflixdata`.
- Make sure to clean headers if there are extra spaces or hidden characters.
   
## 🧠 Project Objectives
- Practice and showcase SQL skills.
- Extract meaningful insights from Netflix's content catalog.
- Build a reusable library of SQL queries for similar datasets.
---

## 🛠 Technologies Used

- **Database**: MySQL
- **Data Format**: CSV (for smooth import into MySQL)
- **Tools**: SQL Workbench

---
## SQL Queries with Objectives, Findings, and Conclusions
---
### 1. Count total records
<pre>SELECT COUNT(*) AS total_titles FROM netflixdata;</pre>
**Objective**:
Find the total number of titles (movies + TV shows) available in the dataset.

**Findings**:
There are X titles in total.

**Conclusion**:
This gives an overview of dataset size, useful for understanding Netflix’s content library scale.

### 2. Get distinct types of content
<pre>SELECT DISTINCT type FROM netflixdata;</pre>
**Objective**:
Identify the different types of content offered (e.g., Movie, TV Show).

**Findings**:
Types include "Movie", "TV Show", and potentially others.

**Conclusion**:
Helps understand content categorization and plan analyses specific to content type.

### 3. Get top 10 recent titles added
<pre> SELECT title, date_added FROM netflixdata ORDER BY date_added DESC LIMIT 10; </pre>
**Objective**:
Retrieve the most recently added content.

**Findings**:
Displays the latest additions to the platform, sorted by date.

**Conclusion**:
Useful for understanding current trends or recent content expansion.

### 4. Count of movies vs TV shows
<pre> SELECT type, COUNT(*) AS count FROM netflixdata GROUP BY type; </pre>
**Objective**:
Compare the number of movies versus TV shows.

**Findings**:
Quantifies how much of each type is available.

**Conclusion**:
Provides insight into Netflix's content strategy balance.

### 5. Get all titles released in 2018
<pre> SELECT title, release_year FROM netflixdata WHERE release_year = 2018; </pre>
**Objective**:
Identify all content released in the year 2018.

**Findings**:
Shows titles launched in a specific year.

**Conclusion**:
Can help in analyzing content output or popularity by year.

### 6. Top 5 countries with most content
<pre> SELECT COALESCE(NULLIF(country, ''), 'Unknown') AS country, COUNT(*) AS count FROM netflixdata GROUP BY COALESCE(NULLIF(country, ''), 'Unknown') ORDER BY count DESC LIMIT 5; </pre>
**Objective**:
Find the countries producing the most content.

**Findings**:
Lists top contributing countries based on content volume.

**Conclusion**:
Useful for geographic content distribution and regional strategy analysis.

### 7. Most frequent directors (ignoring NULL)
<pre> SELECT director, COUNT(director) AS count FROM netflixdata WHERE director IS NOT NULL GROUP BY director ORDER BY count DESC LIMIT 10; </pre>
**Objective**:
Identify directors with the most titles on Netflix.

**Findings**:
Highlights top recurring directors.

**Conclusion**:
May indicate preferred creators or frequent collaborators.

### 8. Titles by rating
<pre> SELECT COALESCE(NULLIF(rating, ''), 'Unknown') AS rating, COUNT(*) AS count FROM netflixdata GROUP BY COALESCE(NULLIF(rating, ''), 'Unknown') ORDER BY count DESC; </pre>
**Objective**:
Analyze how content is distributed across different rating categories.

**Findings**:
Lists ratings (e.g., PG, R, TV-MA) and how many titles fall into each.

**Conclusion**:
Useful for audience segmentation and age-appropriateness assessments.

### 9. Genre frequency (exploding listed_in)
<pre> SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(listed_in, ',', n.n), ',', -1)) AS genre, COUNT(*) AS count FROM netflixdata JOIN ( SELECT a.N + b.N * 10 + 1 n FROM (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a, (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b ) n ON CHAR_LENGTH(listed_in) - CHAR_LENGTH(REPLACE(listed_in, ',', '')) >= n.n - 1 GROUP BY genre ORDER BY count DESC LIMIT 10; </pre>
**Objective**:
Break down and count individual genres from multi-genre listings.

**Findings**:
Reveals most frequent individual genres across all titles.

**Conclusion**:
Provides granular genre trends for strategic recommendations or filtering.

### 10. Duration format breakdown (e.g., movies vs episodes)
<pre> SELECT CASE WHEN duration LIKE '%Season%' THEN 'TV Show' WHEN duration LIKE '%min%' THEN 'Movie' ELSE 'Other' END AS content_type, COUNT(*) AS count FROM netflixdata GROUP BY content_type; </pre>
**Objective**:
Classify content based on duration format into types.

**Findings**:
Differentiates between movies, TV shows, and uncategorized.

**Conclusion**:
Adds validation to the "type" column and provides fallback classification.

### 11. Longest movie titles (by duration)
<pre> SELECT title, duration FROM netflixdata WHERE duration LIKE '%min%' ORDER BY CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) DESC LIMIT 10; </pre>
**Objective**:
Find movies with the longest runtimes.

**Findings**:
Lists top 10 longest movies by minute count.

**Conclusion**:
Useful for identifying epic-length content or time investment required.

### 12. Directors who worked across multiple genres
<pre> SELECT director, COUNT(DISTINCT listed_in) AS unique_genres FROM netflixdata WHERE director IS NOT NULL GROUP BY director ORDER BY unique_genres DESC LIMIT 10; </pre>
**Objective**:
Discover directors with a broad genre range.

**Findings**:
Shows directors involved in diverse genre projects.

**Conclusion**:
Indicates creative versatility or collaboration across categories.

### 13. Simulated recommendation: Similar genres
<pre> SELECT * FROM netflixdata WHERE listed_in LIKE '%Action%' AND release_year > 2015 ORDER BY date_added DESC LIMIT 10; </pre>
**Objective**:
Simulate recommendations based on genre and recent release.

**Findings**:
Provides recent action titles post-2015.

**Conclusion**:
Can be the base logic for building simple recommendation systems.

### 14. Titles where description mentions "Love", "War", or "Life"
<pre> SELECT title, type, release_year, description FROM netflixdata WHERE description REGEXP '\\b(Love|War|Life)\\b' ORDER BY release_year DESC; </pre>
**Objective**:
Extract content with emotionally or thematically rich keywords.

**Findings**:
Lists titles with relevant keywords in their description.

**Conclusion**:
Useful for sentiment-oriented filtering or content curation.

### 15. Top countries producing "Drama" content
<pre> SELECT country, COUNT(*) AS drama_count FROM netflixdata WHERE listed_in LIKE '%Drama%' AND country IS NOT NULL GROUP BY country ORDER BY drama_count DESC LIMIT 10; </pre>
**Objective**:
Identify leading producers of drama content.

**Findings**:
Highlights which countries dominate drama genre production.

**Conclusion**:
Supports genre-specific localization and cultural preferences analysis.
