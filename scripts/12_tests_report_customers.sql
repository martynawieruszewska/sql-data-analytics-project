-- Tests view customer_segment

select * from gold.report_customers

select 
	age_group,
	count(customer_number) as total_customers,
	sum(total_sales) as total_sales
from gold.report_customers 
group by age_group

select 
	customer_segment,
	count(customer_number) as total_customers,
	sum(total_sales) as total_sales
from gold.report_customers 
group by customer_segment