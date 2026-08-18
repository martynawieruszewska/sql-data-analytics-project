/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
*/

-- Calculate the total sales per year
-- and the running total of sales and average price over time
select 
*,
sum(total_sales) over (order by order_year) as running_total_sales,
round(avg(avg_price) over (order by order_year), 2) as running_avg_price
from(
select 
	extract(year from order_date) as order_year,
	sum(sales_amount) as total_sales,
	round(avg(price), 2) as avg_price
from gold.fact_sales
where order_date is not null
group by 
	extract(year from order_date)
order by 
	extract(year from order_date)
)t