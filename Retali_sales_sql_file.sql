-- =====================================================
--  SQL Retail Sales Analysis Project (MySQL Version)
-- =====================================================

-- 1. Create Database
CREATE DATABASE IF NOT EXISTS sql_project_p1;
USE sql_project_p1;

-- 2. Create Table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales (
    transaction_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(20),
    quantity INT,
    price_per_unit DECIMAL(10,2),
    cogs DECIMAL(10,2),
    total_sale DECIMAL(12,2)
);

-- 3. Quick Preview
SELECT * FROM retail_sales LIMIT 10;

-- 4. Data Cleaning
-- Find NULL values
SELECT * FROM retail_sales 
WHERE transaction_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR gender IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

-- Delete NULL rows (if needed)
DELETE FROM retail_sales
WHERE transaction_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR gender IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

-- =====================================================
--  Data Exploration
-- =====================================================

-- How many sales we have?
SELECT COUNT(*) AS total_sales FROM retail_sales;

-- How many unique customers?
SELECT COUNT(DISTINCT customer_id) AS unique_customers FROM retail_sales;

-- Distinct product categories
SELECT DISTINCT category FROM retail_sales;

-- =====================================================
--  Business Analysis Queries
-- =====================================================

-- Q1: Sales made on '2022-11-05'
SELECT * FROM retail_sales 
WHERE sale_date = '2022-11-05';

-- Q2: Clothing transactions with quantity > 4 in Nov-2022
SELECT * FROM retail_sales 
WHERE category = 'Clothing'
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
  AND quantity > 4;

-- Q3: Total sales per category
SELECT category, 
       SUM(total_sale) AS net_sale, 
       COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;

-- Q4: Average age of Beauty customers
SELECT ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';

-- Q5: Transactions where total_sale > 1000
SELECT * FROM retail_sales
WHERE total_sale > 1000;

-- Q6: Number of transactions by gender in each category
SELECT category, gender, COUNT(*) AS total_trans
FROM retail_sales
GROUP BY category, gender
ORDER BY category;

-- Q7A (MySQL 8+): Best selling month per year
SELECT year, month, avg_sale
FROM (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (PARTITION BY YEAR(sale_date) 
                     ORDER BY AVG(total_sale) DESC) AS rnk
    FROM retail_sales
    GROUP BY year, month
) t
WHERE rnk = 1;

-- Q7B (MySQL <8.0): Best selling month per year (without RANK)
SELECT t.year, t.month, t.avg_sale
FROM (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sale
    FROM retail_sales
    GROUP BY year, month
) t
JOIN (
    SELECT 
        YEAR(sale_date) AS year,
        MAX(avg_sale) AS max_avg_sale
    FROM (
        SELECT 
            YEAR(sale_date) AS year,
            MONTH(sale_date) AS month,
            AVG(total_sale) AS avg_sale
        FROM retail_sales
        GROUP BY year, month
    ) sub
    GROUP BY year
) m ON t.year = m.year AND t.avg_sale = m.max_avg_sale;

-- Q8: Top 5 customers by highest total sales
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- Q9: Unique customers per category
SELECT category, COUNT(DISTINCT customer_id) AS cnt_unique_cs
FROM retail_sales
GROUP BY category;

-- Q10: Orders by shift (Morning <12, Afternoon 12-17, Evening >17)
SELECT 
    CASE 
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY shift;

-- =====================================================
-- End of Project
-- =====================================================
