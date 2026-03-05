-- DATA EXPLORATION

-- ==============================================
-- Total Revenue
-- ==============================================

SELECT SUM(`Total Spent`) AS Total_Revenue
FROM retail_store_sales2;


-- ==============================================
-- Total Transactions
-- ==============================================

SELECT COUNT(`Transaction ID`) AS Total_Transactions
FROM retail_store_sales2;


-- ==============================================
-- Average Transaction Value
-- ==============================================

SELECT AVG(`Total Spent`) AS Avg_Transaction_Value
FROM retail_store_sales;


-- ==============================================
 -- Total Quantity Sold
-- ==============================================

SELECT SUM(Quantity) AS Total_Quantity_Sold
FROM retail_store_sales2;


-- ==============================================
-- Revenue by Location
-- ==============================================

SELECT Location,
       SUM(`Total Spent`) AS Location_Revenue
FROM retail_store_sales2
GROUP BY Location
ORDER BY Location_Revenue DESC;


-- ==============================================
 -- Revenue by Customer Category
-- ==============================================

SELECT Category,
       SUM(`Total Spent`) AS Revenue
FROM retail_store_sales2
GROUP BY Category
ORDER BY Revenue DESC;


-- ==============================================
-- Top 10 Best-Selling Products
-- ==============================================

SELECT Item,
       SUM(Quantity) AS Total_Quantity_Sold
FROM retail_store_sales2
GROUP BY Item
ORDER BY Total_Quantity_Sold DESC
LIMIT 10;


-- ==============================================
 -- Payment Method Analysis
-- ==============================================

SELECT `Payment Method`,
       COUNT(*) AS Total_Transactions,
       SUM(`Total Spent`) AS Revenue
FROM retail_store_sales
GROUP BY `Payment Method`
ORDER BY Revenue DESC;


-- ==============================================
-- Discount Impact Analysis
-- ==============================================

SELECT `Discount Applied`,
       COUNT(*) AS Transactions,
       AVG(`Total Spent`) AS Avg_Spend
FROM retail_store_sales2
GROUP BY `Discount Applied`;


-- ==============================================
-- MAIN CORE BUSINESS INSIGHT QUERY
-- ==============================================

SELECT 
    Location,
    Category,
    SUM(`Total Spent`) AS Revenue,
    ROUND(
        (SUM(`Total Spent`) / 
        (SELECT SUM(`Total Spent`) FROM retail_store_sales2)) * 100, 2
    ) AS Revenue_Percentage,
    RANK() OVER (ORDER BY SUM(`Total Spent`) DESC) AS Revenue_Rank
FROM retail_store_sales2
GROUP BY Location,Category
ORDER BY Revenue DESC;


-- ==============================================
-- Monthly Revenue Trend (Time-Series)
-- ==============================================

SELECT DATE_FORMAT(`Transaction Date`, '%Y-%m') AS Month,
       SUM(`Total Spent`) AS Monthly_Revenue
FROM retail_store_sales2
GROUP BY Month
ORDER BY Month;


-- ==============================================
 -- Customer Lifetime Value
-- ==============================================

SELECT `Customer ID`,
       SUM(`Total Spent`) AS Lifetime_Value
FROM retail_store_sales2
GROUP BY `Customer ID`
ORDER BY Lifetime_Value DESC
LIMIT 10;
