/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER(), TOP
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/

-- Which 5 products Generating the Highest Revenue?
-- Simple Ranking
select
	p.product_name,
	sum(f.sales_amount) as total_revenue
from gold.fact_sales f
left join gold.dim_products p
on p.product_key  = f.product_key 
group by p.product_name 
order by sum(f.sales_amount) desc 
limit 5

-- Complex but Flexibly Ranking Using Window Functions
select 
*
from (
select
	p.product_name,
	sum(f.sales_amount) as total_revenue,
	row_number() over (order by sum(f.sales_amount) desc) as rank_products
from gold.fact_sales f
left join gold.dim_products p
on p.product_key  = f.product_key 
group by p.product_name 
)t where rank_products <= 5

-- What are the 5 worst-performing products in terms of sales?
select
	p.product_name,
	sum(f.sales_amount) as total_revenue
from gold.fact_sales f
left join gold.dim_products p
on p.product_key  = f.product_key 
group by p.product_name 
order by sum(f.sales_amount) 
limit 5

-- Find the top 10 customers who have generated the highest revenue
select 
	f.customer_key,
	c.first_name,
	c.last_name,
	sum(f.sales_amount) as total_revenue
from gold.fact_sales f
left join gold.dim_customers c
on f.customer_key = c.customer_key 
group by 
	f.customer_key,
	c.first_name,
	c.last_name
order by sum(f.sales_amount) desc
limit 10

-- The 3 customers with the fewest orders placed
select 
	f.customer_key,
	c.first_name,
	c.last_name,
	count(distinct f.order_number) as total_orders
from gold.fact_sales f
left join gold.dim_customers c
on f.customer_key = c.customer_key 
group by 
	f.customer_key,
	c.first_name,
	c.last_name
order by count(distinct f.order_number)
limit 3

