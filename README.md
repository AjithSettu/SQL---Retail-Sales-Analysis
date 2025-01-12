# Retail Sales Analysis Project

This repository contains a SQL-based project focused on analyzing retail sales data. The project involves creating a database, cleaning the data, performing exploratory analysis, and addressing business-related problems through SQL queries.

---

## Table of Contents
- [Database Setup](#database-setup)
- [Table Structure](#table-structure)
- [Data Cleaning](#data-cleaning)
- [Data Exploration](#data-exploration)
- [Data Analysis and Business Questions](#data-analysis-and-business-questions)
  - [1. Sales on a Specific Date](#1-sales-on-a-specific-date)
  - [2. Sales for Clothing Category with Quantity > 4](#2-sales-for-clothing-category-with-quantity--4)
  - [3. Total Sales by Category](#3-total-sales-by-category)
  - [4. Average Age for the 'Beauty' Category](#4-average-age-for-the-beauty-category)
  - [5. Transactions with Total Sales > 1000](#5-transactions-with-total-sales--1000)
  - [6. Total Transactions by Gender and Category](#6-total-transactions-by-gender-and-category)
  - [7. Average Sales and Best-Selling Month](#7-average-sales-and-best-selling-month)
  - [8. Top 5 Customers by Total Sales](#8-top-5-customers-by-total-sales)
  - [9. Unique Customers per Category](#9-unique-customers-per-category)
  - [10. Orders by Shift](#10-orders-by-shift)

---

## Database Setup

### Create Database
```sql
CREATE DATABASE [Projects];
USE [Projects];
```

### Create Table
```sql
CREATE TABLE Retail_Sales (
    transactions_id INT,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(100),
    age INT,
    category VARCHAR(100),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

---

## Data Cleaning

### Check for NULL Values
```sql
SELECT * FROM [SQL - Retail Sales Analysis_utf]
WHERE transactions_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR gender IS NULL
    OR customer_id IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR price_per_unit IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;
```

### Delete NULL Values
```sql
DELETE FROM [SQL - Retail Sales Analysis_utf]
WHERE transactions_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR gender IS NULL
    OR customer_id IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR price_per_unit IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;
```

---

## Data Exploration

### Total Sales Count
```sql
SELECT COUNT(transactions_id) FROM [SQL - Retail Sales Analysis_utf];
```

### Unique Customers
```sql
SELECT COUNT(DISTINCT customer_id) AS Unique_Customers FROM [SQL - Retail Sales Analysis_utf];
```

### Unique Categories
```sql
SELECT COUNT(DISTINCT category) AS Unique_Categories FROM [SQL - Retail Sales Analysis_utf];
```

---

## Data Analysis and Business Questions

### 1. Sales on a Specific Date
```sql
SELECT * FROM [SQL - Retail Sales Analysis_utf]
WHERE sale_date = '2022-11-05';
```

### 2. Sales for Clothing Category with Quantity > 4
```sql
SELECT * FROM [SQL - Retail Sales Analysis_utf]
WHERE category = 'Clothing' 
    AND quantity > 4
    AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';
```

### 3. Total Sales by Category
```sql
SELECT category, SUM(total_sale) AS Total_Sales
FROM [SQL - Retail Sales Analysis_utf]
GROUP BY category;
```

### 4. Average Age for the 'Beauty' Category
```sql
SELECT AVG(age) AS Average_Age
FROM [SQL - Retail Sales Analysis_utf]
WHERE category = 'Beauty';
```

### 5. Transactions with Total Sales > 1000
```sql
SELECT * FROM [SQL - Retail Sales Analysis_utf]
WHERE total_sale > 1000;
```

### 6. Total Transactions by Gender and Category
```sql
SELECT COUNT(DISTINCT transactions_id) AS Total_Transactions, gender, category
FROM [SQL - Retail Sales Analysis_utf]
GROUP BY gender, category
ORDER BY Total_Transactions DESC;
```

### 7. Average Sales and Best-Selling Month
```sql
WITH MonthlySales AS (
    SELECT 
        YEAR(sale_date) AS Year,
        MONTH(sale_date) AS Month,
        AVG(total_sale) AS Average_Sales,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS Rank
    FROM [SQL - Retail Sales Analysis_utf]
    GROUP BY YEAR(sale_date), MONTH(sale_date)
)
SELECT Year, Month, Average_Sales
FROM MonthlySales
WHERE Rank = 1;
```

### 8. Top 5 Customers by Total Sales
```sql
SELECT TOP 5 customer_id, SUM(total_sale) AS Total_Sales
FROM [SQL - Retail Sales Analysis_utf]
GROUP BY customer_id
ORDER BY Total_Sales DESC;
```

### 9. Unique Customers per Category
```sql
SELECT category, COUNT(DISTINCT customer_id) AS Unique_Customers
FROM [SQL - Retail Sales Analysis_utf]
GROUP BY category;
```

### 10. Orders by Shift
```sql
WITH SalesByHour AS (
    SELECT *, 
           CASE 
               WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
               WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
               ELSE 'Evening'
           END AS Shift
    FROM [SQL - Retail Sales Analysis_utf]
)
SELECT Shift, COUNT(*) AS Total_Orders
FROM SalesByHour
GROUP BY Shift;
```

---

## Conclusion
This project provides insights into retail sales through SQL queries, enabling better decision-making.

