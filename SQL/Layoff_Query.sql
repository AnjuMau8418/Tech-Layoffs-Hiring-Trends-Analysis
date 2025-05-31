
-- Total Layoffs since 2020

SELECT *
FROM Layoffs_Dataset

SELECT SUM([Number_of_Layoff]) AS Total_layoffs 
FROM Layoffs_Dataset
WHERE Layoff_Year = 2024;

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

-- Bottom 10 Compnies by Least Layoffs

SELECT TOP 10 Company, SUM(Number_of_Layoff) AS Total_Layoffs
FROM Layoffs_Dataset
GROUP BY Company
ORDER BY Total_Layoffs ASC;


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


--- Companies with Multiple Layoff Events

SELECT Company, COUNT(*) AS Layoff_Events, SUM(Number_of_Layoff) AS Total_Layoffs
FROM Layoffs_Dataset
GROUP BY Company
HAVING COUNT(*) > 1
ORDER BY Layoff_Events DESC;

---  Running Total of Layoffs Over Time
SELECT Layoff_Year, Layoff_Quarter,
       SUM(Number_of_Layoff) OVER (ORDER BY Layoff_Year, Layoff_Quarter) AS Cumulative_Layoffs
FROM Layoffs_Dataset;

--- Top Companies per Year

WITH RankedCompanies AS (
    SELECT 
        Layoff_Year,
        Company,
        SUM(Number_of_Layoff) AS Total_Layoffs,
        ROW_NUMBER() OVER (PARTITION BY Layoff_Year ORDER BY SUM(Number_of_Layoff) DESC) AS rn
    FROM Layoffs_Dataset
    GROUP BY Layoff_Year, Company
)
SELECT 
    Layoff_Year,
    Company,
    Total_Layoffs
FROM RankedCompanies
WHERE rn = 1;

--- Average Layoffs per Event by Industry

SELECT Industry,
       COUNT(*) AS Events,
       SUM(Number_of_Layoff) AS Total_Layoffs,
       AVG(Number_of_Layoff) AS Avg_Layoffs_Per_Event
FROM Layoffs_Dataset
GROUP BY Industry
ORDER BY Avg_Layoffs_Per_Event DESC;

--- Filtering Specific Conditions

-- All the data for the US for year 2023

SELECT * 
FROM Layoffs_Dataset
WHERE Country = 'United States' AND Layoff_Year = 2023;



