SQL Data Analytics Project

Overview

This project focuses on analyzing sales data using PostgreSQL. The goal is to explore customer and product behavior, identify sales trends, and build reusable analytical reports using SQL.

The project works with a simple star schema consisting of:

* gold.fact_sales – sales transactions
* gold.dim_customers – customer information
* gold.dim_products – product information

Analysis

The project covers several areas of data analysis:

* Exploratory Data Analysis – key sales, customer, and product metrics
* Change Over Time Analysis – monthly and yearly sales trends
* Cumulative Analysis – running totals and moving averages
* Performance Analysis – year-over-year product performance using window functions
* Data Segmentation – customer and product segmentation
* Part-to-Whole Analysis – category contribution to overall sales

Reports

Two analytical views summarize the most important business metrics:

Customer Report

gold.report_customers

Includes customer segmentation, age groups, total sales, orders, purchased products, lifespan, recency, average order value, and average monthly spend.

Product Report

gold.report_products

Includes product segmentation, total sales, orders, customers, lifespan, recency, average selling price, average order revenue, and average monthly revenue.

SQL Skills Used

* Joins and aggregations
* Common Table Expressions (CTEs)
* Window functions (LAG, SUM OVER, AVG OVER)
* CASE expressions
* Date functions (EXTRACT, AGE, DATE_TRUNC)
* Customer and product segmentation
* KPI calculations
* Views

Tools

* PostgreSQL 18
* DBeaver
* Git & GitHub
