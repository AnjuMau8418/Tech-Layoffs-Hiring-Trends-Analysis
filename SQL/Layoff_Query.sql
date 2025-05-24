
--- Basic Table View --
SELECT *
FROM Layoffs_Dataset

-- Total Row Count 
SELECT COUNT(*) AS Total_Rows
FROM Layoffs_Dataset;

-- Top 5 rows of the table
SELECT TOP 5 *
FROM Layoffs_Dataset

-- Total Layoffs since 2020

SELECT SUM([Number_of_Layoff]) AS Total_layoffs FROM Layoffs_Dataset;

-- Layoff by years
SELECT Layoff_Year, SUM([Number_of_Layoff]) AS Total_Layoffs
FROM Layoffs_Dataset
GROUP BY Layoff_Year
ORDER BY Total_Layoffs DESC

-- Layoffs by industry

SELECT Industry, SUM(Number_of_Layoff) AS Total_Layoffs
FROM Layoffs_Dataset
GROUP BY Industry
ORDER BY Total_Layoffs DESC

-- Top 10 Compnies with Most Layoff

SELECT TOP 10 Company, SUM(Number_of_Layoff) AS Total_Layoffs
FROM Layoffs_Dataset
GROUP BY Company
ORDER BY Total_Layoffs DESC

-- Top 10 Country with Most Layoff

SELECT Top 10 Country, SUM(Number_of_Layoff) AS Total_Layoffs
FROM Layoffs_Dataset
GROUP BY Country
ORDER BY Total_Layoffs DESC

-- Bottom 5 Compnies by Least Layoffs

SELECT Top 10 Country, SUM(Number_of_Layoff) AS Total_Layoffs
FROM Layoffs_Dataset
GROUP BY Country
ORDER BY Total_Layoffs ASC

---  Layoff Trend by Quarter

SELECT  Layoff_Quarter, SUM(Number_of_Layoff) AS Total_Layoffs
FROM Layoffs_Dataset
GROUP BY  Layoff_Quarter
ORDER BY  Total_Layoffs DESC
 
-- Severity Categories Distribution

SELECT Layoff_Severity, COUNT(*) AS Count
FROM Layoffs_Dataset
GROUP BY Layoff_Severity;

-- Layoffs vs. Funding Category

SELECT Funding_Category, SUM(Number_of_Layoff) AS Total_Layoffs
FROM Layoffs_Dataset
GROUP BY Funding_Category
ORDER BY Total_Layoffs DESC;

-- Funding Stage-wise Layoff Analysis

SELECT Stage, SUM(Number_of_Layoff) AS Total_Layoffs
FROM Layoffs_Dataset
GROUP BY Stage
ORDER BY Total_Layoffs DESC;

-- Year by Year % change in the Layoffs

WITH Yearly AS (
  SELECT Layoff_Year, SUM(Number_of_Layoff) AS Total_Layoffs
  FROM Layoffs_Dataset
  GROUP BY Layoff_Year
)
SELECT 
  A.Layoff_Year,
  A.Total_Layoffs,
  ((A.Total_Layoffs - B.Total_Layoffs) * 100.0 / B.Total_Layoffs) AS YoY_Change_Percent
FROM Yearly A
JOIN Yearly B ON A.Layoff_Year = B.Layoff_Year + 1;

--- Filtering Specific Conditions

-- All the data for the US for year 2023

SELECT * 
FROM Layoffs_Dataset
WHERE Country = 'United States' AND Layoff_Year = 2023;



