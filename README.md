##Retail Sales Analysis SQL Project
Project Overview

Project Title: Retail Sales Analysis
Level: Beginner
Database: p1_retail_db

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales 
database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. It is an ideal project for beginners who are starting their journey in data 
analysis and want to build a solid foundation in SQL using MySQL.

##Objectives

Set up a retail sales database: Create and populate a retail sales database with the provided sales data.

Data Cleaning: Identify and remove any records with missing or null values.

Exploratory Data Analysis (EDA): Perform queries to understand the dataset and uncover key patterns.

Business Analysis: Use SQL to answer important business questions and generate insights from the sales data.

#Project Structure
#1. Database Setup

The project begins by creating a database named p1_retail_db and a table named retail_sales that stores transaction-level sales data. The table contains fields for transaction ID, sale date, 
sale time, customer ID, gender, age, product category, quantity, price per unit, cost of goods sold (COGS), and total sale amount.

#2. Data Exploration & Cleaning

SQL queries are used to check record counts, unique customers, distinct product categories, and missing values. Rows with NULL values are deleted to ensure data quality before analysis.

#3. Data Analysis & Findings

The project answers the following business questions using SQL:

Retrieve all sales made on 2022-11-05.

Find transactions where the category is Clothing and quantity > 4 in November 2022.

Calculate total sales for each category.

Find the average age of customers who purchased from the Beauty category.

Retrieve all transactions where total_sale > 1000.

Count the number of transactions made by each gender in each category.

Calculate the average monthly sales and find the best-selling month in each year.

Identify the top 5 customers based on total sales.

Find the number of unique customers per product category.

Categorize transactions into Morning (<12), Afternoon (12–17), and Evening (>17) shifts and count the orders in each shift.

#Findings

The dataset covers customers from various age groups with sales across different categories.

Some transactions exceeded 1000+ total sale value, indicating premium purchases.

Monthly analysis revealed variations in sales volume, highlighting peak sales months.

Analysis identified top-spending customers and most popular product categories.

#Reports

Sales Summary: Shows total sales, customer demographics, and category performance.

Trend Analysis: Provides insights into sales trends across months and shifts.

Customer Insights: Highlights top customers and unique buyers by category.

#Conclusion

This project serves as a complete beginner-friendly SQL project. It covers database setup, data cleaning, exploratory data analysis, and solving business-driven queries in MySQL.
The findings can be applied to support business decisions, optimize marketing strategies, and understand customer behavior.
