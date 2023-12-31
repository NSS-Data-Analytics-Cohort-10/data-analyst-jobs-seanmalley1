-- The dataset for this exercise has been derived from the Indeed Data Scientist/Analyst/Engineer dataset on kaggle.com.

-- Before beginning to answer questions, take some time to review the data dictionary and familiarize yourself with the data that is contained in each column.

-- Provide the SQL queries and answers for the following questions/tasks using the data_analyst_jobs table you have created in PostgreSQL:
-- How many rows are in the data_analyst_jobs table?

SELECT COUNT (*)
FROM data_analyst_jobs;

--1793

-- Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row? (ExxonMobil)

SELECT *
FROM data_analyst_jobs
LIMIT 10;

--ExxonMobil


--How many postings are in Tennessee? (21)
SELECT COUNT(location)
FROM data_analyst_jobs
WHERE location = 'TN';

-- How many are there in either Tennessee or Kentucky? (27)

SELECT COUNT(location)
FROM data_analyst_jobs
WHERE location = 'TN' OR location ='KY';
or
SELECT COUNT(location)
FROM data_analyst_jobs
WHERE LOCATION IN ('TN', 'KY');

-- How many postings in Tennessee Have a star rating above 4? (3)

SELECT COUNT(location)
FROM data_analyst_jobs
WHERE location = 'TN' AND star_rating > 4;

-- How many postings in the dataset have a review count between 500 and 1000? (151)
SELECT COUNT(*)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;

-- Show the average star rating for companies in each state. The output should show the state as state and the average rating for the state as avg_rating. Which state shows the highest average rating? (NE)

SELECT 
	location as state, 
	AVG(star_rating) as avg_rating
FROM data_analyst_jobs
GROUP BY location
ORDER BY avg_rating DESC;

--or

SELECT location as state, AVG(star_rating) as avg_rating
FROM data_analyst_jobs
GROUP BY location
ORDER BY avg_rating DESC;


--Q7 Select unique job titles from the data_analyst_jobs table. How many are there? (881)
SELECT COUNT(DISTINCT(title))
FROM data_analyst_jobs;

-- How many unique job titles are there for California companies? (230)

SELECT COUNT(DISTINCT(title))
FROM data_analyst_jobs
WHERE location = 'CA';

-- Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations.

SELECT company, AVG(star_rating) AS average_star_rating, SUM(review_count)
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company
ORDER BY company ASC;

--Q 9B How many companies are there with more that 5000 reviews across all locations? (40)

SELECT company, AVG(star_rating)
FROM data_analyst_jobs
WHERE review_count > 5000
	AND company IS NOT NULL
GROUP BY company;


--Q10 Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? (Unilever, General Motors,Nike,American Express,Microsoft,Kaiser Permanente) What is that rating? (4.199)

SELECT company, AVG(star_rating) AS average_star_rating
FROM data_analyst_jobs
WHERE review_count > 5000
AND company IS NOT NULL
GROUP BY company
ORDER BY average_star_rating DESC;

--Q11 Find all the job titles that contain the word ‘Analyst’. 

SELECT DISTINCT LOWER(title)
FROM data_analyst_jobs
WHERE LOWER(title) LIKE '%analyst%'  

--How many different job titles are there? (770 or 774, depending)

SELECT COUNT(DISTINCT(LOWER(title)))
FROM data_analyst_jobs
WHERE LOWER(title) LIKE '%analyst%' 
--770
-- or

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%';
--774

-- Q12 How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? (4)

-- SELECT COUNT(DISTINCT(title))
-- FROM data_analyst_jobs
-- WHERE LOWER(title) NOT LIKE '%Analyst%' AND LOWER(title) NOT LIKE '%Analytics%';
-- (why does this not work?)

SELECT COUNT(DISTINCT(title))
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analyst%' AND title NOT ILIKE '%Analytics%';
-- 4

--What word do these positions have in common? (tableau)

SELECT (title)
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analyst%' AND title NOT ILIKE '%Analytics%';
--Tableau

-- BONUS: You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks.
-- Disregard any postings where the domain is NULL.
-- Order your results so that the domain with the greatest number of hard to fill jobs is at the top.
-- Which four industries are in the top 4 on this list? (Internet and Software, Banks and Financial Services, Consulting and Business)
SELECT domain, COUNT(title)
FROM data_analyst_jobs
WHERE skill ILIKE '%SQL%' AND days_since_posting > 21 AND domain IS NOT NULL
GROUP BY domain
ORDER BY COUNT(title) DESC
LIMIT 4
--How many jobs have been listed for more than 3 weeks for each of the top 4?
-- Internet and Software 62
--Banks and Financial 61
--Consulting and Business Services 57
--Health Care 52






