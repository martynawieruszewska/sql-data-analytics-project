/*
===============================================================================
Product Report
===============================================================================
Purpose:
    - This report consolidates key product metrics and behaviors.

Highlights:
    1. Gathers essential fields such as product name, category, subcategory, and cost.
    2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
    3. Aggregates product-level metrics:
       - total orders
       - total sales
       - total quantity sold
       - total customers (unique)
       - lifespan (in months)
    4. Calculates valuable KPIs:
       - recency (months since last sale)
       - average order revenue (AOR)
       - average monthly revenue
===============================================================================
*/

-- =============================================================================
-- Create Report: gold.report_products
-- =============================================================================

drop view if exists gold.report_products;

create view gold.report_products as

with base_query as (

/*---------------------------------------------------------------------------
1) Base Query: Retrieves core columns from fact_sales and dim_products
---------------------------------------------------------------------------*/

select 
	f.order_number,
    f.order_date,
    f.customer_key,
    f.sales_amount,
    f.quantity,
    p.product_key,
    p.product_name,
    p.category,
    p.subcategory,
    p.cost
from gold.fact_sales f
left join gold.dim_products p
on f.product_key = p.product_key 
where f.order_date is not null
),

product_aggregations as (

/*---------------------------------------------------------------------------
2) Product Aggregations: Summarizes key metrics at the product level
---------------------------------------------------------------------------*/

select
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	extract(year from age(max(order_date), min(order_date))) * 12 + extract(month from age(max(order_date), min(order_date))) as lifespan,
	max(order_date) as last_order_date,
	count(distinct order_number) as total_orders,
	count(distinct customer_key) as total_customers,
	sum(sales_amount) as total_sales,
	sum(quantity) as total_quantity,
	round(avg(sales_amount::numeric / nullif(quantity, 0)), 1) as avg_selling_price
from base_query
group by 
	product_key,
	product_name,
	category,
	subcategory,
	cost
)

/*---------------------------------------------------------------------------
3) Final Query: Combines all product results into one output
---------------------------------------------------------------------------*/

select 
	product_key,
    product_name,
    category,
    subcategory,
    cost,
    last_sale_date,
    extract(year from age(current_date, last_sale_date)) * 12 + extract(month from age(current_date, last_dale_date)) as recency_in_months,
    case
    	when total_sales > 50000 then 'High-Performer'
    	when total_sales >= 10000 then 'Mid-Range'
    	else 'Low-Performer'
    end as product_segment
    



/*---------------------------------------------------------------------------
3) Final Query: Combines all product results into one output
---------------------------------------------------------------------------*/


    CASE
        WHEN total_sales > 50000 THEN 'High-Performer'
        WHEN total_sales >= 10000 THEN 'Mid-Range'
        ELSE 'Low-Performer'
    END AS product_segment,

    lifespan,
    total_orders,
    total_sales,
    total_quantity,
    total_customers,
    avg_selling_price,

    -- Average Order Revenue (AOR)
    CASE
        WHEN total_orders = 0 THEN 0
        ELSE ROUND(total_sales::NUMERIC / total_orders, 2)
    END AS avg_order_revenue,

    -- Average Monthly Revenue
    CASE
        WHEN lifespan = 0 THEN total_sales
        ELSE ROUND(total_sales::NUMERIC / lifespan, 2)
    END AS avg_monthly_revenue

FROM product_aggregations;