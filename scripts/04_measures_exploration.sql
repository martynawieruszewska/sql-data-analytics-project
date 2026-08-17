/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/

-- Find the Total Sales
select sum(sales_amount) as total_sales from gold.fact_sales;

-- Find how many items are sold
select sum(quantity) as total_quantity from gold.fact_sales;

-- Find the average selling price
select avg(price) as avg_price from gold.fact_sales;

-- Find the Total number of Orders
select count(order_number) as total_orders from gold.fact_sales;
select count(distinct order_number) as total_orders from gold.fact_sales;
select * from gold.fact_sales

-- Find the total number of products
select count(product_key) as total_products from gold.dim_products;
select count(distinct product_key) as total_orders from gold.dim_products;

-- Find the total number of customers
select count(customer_key) as total_customers from gold.dim_customers;

-- Find the total number of customers that has placed an order
select count(distinct customer_key) as total_customers from gold.fact_sales;

-- Generate a Report that shows all key metrics of the business
SELECT 
    'Total Sales' AS measure_name, 
    SUM(sales_amount) AS measure_value 
FROM gold.fact_sales

UNION ALL

SELECT 
    'Total Quantity', 
    SUM(quantity) 
FROM gold.fact_sales

UNION ALL

SELECT 
    'Average Price', 
    AVG(price) 
FROM gold.fact_sales

UNION ALL

SELECT 
    'Total Nr. Orders', 
    COUNT(DISTINCT order_number) 
FROM gold.fact_sales

UNION ALL

SELECT 
    'Total Nr. Products', 
    COUNT(product_name) 
FROM gold.dim_products

UNION ALL

SELECT 
    'Total Nr. Customers', 
    COUNT(customer_key) 
FROM gold.dim_customers;