-- Superstore Sales Analysis
-- Analyst: Jiya Garg
-- Dataset: 4,922 orders | US Retail 2015-2018
-- Tool: SQLite

-- ================================================
-- QUERY 1: Total Sales by Region
-- ================================================
SELECT c13, 
       SUM(CAST(REPLACE(c18, '$', '') AS REAL)) AS total_sales
FROM Superstore_Cleancsv
WHERE c13 != 'Region'
GROUP BY c13
ORDER BY SUM(CAST(REPLACE(c18, '$', '') AS REAL)) DESC;

-- ================================================
-- QUERY 2: Total Sales by Category
-- ================================================
SELECT c15, 
       SUM(CAST(REPLACE(c18, '$', '') AS REAL)) AS total_sales
FROM Superstore_Cleancsv
WHERE c15 != 'Category'
GROUP BY c15
ORDER BY SUM(CAST(REPLACE(c18, '$', '') AS REAL)) DESC;

-- ================================================
-- QUERY 3: Order Count by Region
-- ================================================
SELECT c13, COUNT(*) AS order_count
FROM Superstore_Cleancsv
WHERE c13 != 'Region'
GROUP BY c13;

-- ================================================
-- QUERY 4: Top 5 Highest Value Orders
-- ================================================
SELECT c13 AS region, c15 AS category, c18 AS sales
FROM Superstore_Cleancsv
WHERE c13 != 'Region' AND c15 != 'Category' AND c18 != 'Sales'
ORDER BY CAST(REPLACE(c18, '$', '') AS REAL) DESC
LIMIT 5;

-- ================================================
-- QUERY 5: Orders Above Average Sale Value (Subquery)
-- ================================================
SELECT COUNT(*) AS orders_above_average
FROM Superstore_Cleancsv
WHERE CAST(REPLACE(c18, '$', '') AS REAL) > (
    SELECT AVG(CAST(REPLACE(c18, '$', '') AS REAL))
    FROM Superstore_Cleancsv
    WHERE c18 != 'Sales'
);

-- ================================================
-- QUERY 6: Regional Sales Ranking (Window Function)
-- ================================================
SELECT c13 AS region,
       SUM(CAST(REPLACE(c18, '$', '') AS REAL)) AS total_sales,
       RANK() OVER (ORDER BY SUM(CAST(REPLACE(c18, '$', '') AS REAL)) DESC) AS rank
FROM Superstore_Cleancsv
WHERE c13 != 'Region'
GROUP BY c13;

-- ================================================
-- KEY FINDINGS:
-- 1. West region leads revenue at $204,057
-- 2. Office Supplies is top category at $228,818
-- 3. Only 28% of orders (1,386) exceed average sale value
-- 4. South is consistently weakest region
-- 5. Technology drives highest individual order values
-- ================================================