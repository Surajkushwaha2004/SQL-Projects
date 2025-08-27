# 🛍️ Retail Sales Analysis SQL Project

## 📌 Project Overview
This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data.  
The project covers setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries.  
It is ideal for beginners who want to practice using SQL and strengthen their query-building skills.

---

## 🎯 Objectives
1. Set up and initialize the database.  
2. Clean and explore retail sales data.  
3. Apply SQL techniques to analyze customer behavior, sales trends, and product categories.  
4. Generate insights such as best-performing categories, customer demographics, and sales trends.  

---

## 📂 Project Structure

### 1. Database Setup
**Database Creation**  
```sql
CREATE DATABASE IF NOT EXISTS retail_sales;
USE retail_sales;


##Table creation
CREATE TABLE IF NOT EXISTS retail_sales (
    transaction_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(20),
    quantity INT,
    price_per_unit FLOAT,
    total_sale FLOAT
);

##Data Exploration & Cleaning
SELECT COUNT(*) FROM retail_sales;

##Customer Count – Unique customers:
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

##Category Count – Unique product categories:
SELECT DISTINCT category FROM retail_sales;

##Handling Missing Values – Identify and delete null records:
SELECT * FROM retail_sales
WHERE transaction_id IS NULL 
   OR sale_date IS NULL 
   OR sale_time IS NULL 
   OR customer_id IS NULL 
   OR gender IS NULL 
   OR age IS NULL 
   OR category IS NULL 
   OR quantity IS NULL 
   OR price_per_unit IS NULL 
   OR total_sale IS NULL;

DELETE FROM retail_sales
WHERE transaction_id IS NULL 
   OR sale_date IS NULL 
   OR sale_time IS NULL 
   OR customer_id IS NULL 
   OR gender IS NULL 
   OR age IS NULL 
   OR category IS NULL 
   OR quantity IS NULL 
   OR price_per_unit IS NULL 
   OR total_sale IS NULL;

##Data Analysis & Findings
##1. Sales on 2022-11-05
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

##2. Clothing sales in November 2022
SELECT * FROM retail_sales
WHERE category = 'Clothing'
  AND MONTH(sale_date) = 11
  AND YEAR(sale_date) = 2022;

##3. Total sales by category
SELECT category, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY category;

##4. Average age of customers in Beauty category
SELECT AVG(age) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';

##5. Transactions where total_sale > 1000
SELECT * FROM retail_sales
WHERE total_sale > 1000;

##6. Sales count by gender and category
SELECT category, gender, COUNT(*) AS total_trans
FROM retail_sales
GROUP BY category, gender;

##7. Best-selling month each year
SELECT year, month, total_sales FROM (
    SELECT YEAR(sale_date) AS year,
           MONTH(sale_date) AS month,
           SUM(total_sale) AS total_sales,
           RANK() OVER (PARTITION BY YEAR(sale_date)
                        ORDER BY SUM(total_sale) DESC) AS rnk
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) ranked
WHERE rnk = 1;

##8. Top 5 customers by sales
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

##9. Unique customers by category
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;

##10. Sales by time shift (Morning/Afternoon/Evening)
SELECT CASE 
         WHEN HOUR(sale_time) < 12 THEN 'Morning'
         WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
         ELSE 'Evening'
       END AS shift,
       COUNT(*) AS total_orders
FROM retail_sales
GROUP BY shift;

##📊 Findings

Customer Demographics: Data includes both genders across different age groups.

Category Trends: Clothing and Electronics generate higher sales volume.

Sales Trends: Certain months show peak demand, with November being strong (likely festive sales).

High Value Orders: Transactions above 1000 are less frequent but contribute significantly to revenue.

##📝 Reports

Customer Report – Age distribution, gender breakdown, and unique customers per category.

Sales Report – Monthly and category-wise sales performance.

Product Report – Best-selling categories and top customers by revenue.

##✅ Conclusion

This project is a beginner-friendly introduction to SQL for data analysis, covering database setup, data cleaning, exploratory data analysis, and business insights.
The queries demonstrate how SQL can be applied to real-world datasets to uncover trends, patterns, and actionable insights.
