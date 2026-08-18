-- Test view product_customer

select * from gold.report_products

select 	
	product_segment,
	count(product_key) as total_products,
	sum(total_sales) as total_sales
from gold.report_products
group by product_segment
order by total_sales desc

select 	
	category,
	count(product_key) as total_products,
	sum(total_sales) as total_sales
from gold.report_products
group by category
order by total_sales desc