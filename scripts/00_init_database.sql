/*
=============================================================
Create Database
=============================================================
Script Purpose:
    This script creates a new database named DataWarehouseAnalytics.

WARNING:
    If the database already exists, it will be dropped.
    All data inside it will be permanently deleted.
*/

DROP DATABASE IF EXISTS "DataWarehouseAnalytics";

CREATE DATABASE "DataWarehouseAnalytics"; 
/*
=============================================================
Create Schema and Tables
=============================================================
*/

-- Drop and recreate schema
DROP SCHEMA IF EXISTS gold CASCADE;

CREATE SCHEMA gold;


-- ============================================================
-- Create dim_customers
-- ============================================================

CREATE TABLE gold.dim_customers (
    customer_key      INTEGER,
    customer_id       INTEGER,
    customer_number   VARCHAR(50),
    first_name        VARCHAR(50),
    last_name         VARCHAR(50),
    country           VARCHAR(50),
    marital_status    VARCHAR(50),
    gender            VARCHAR(50),
    birthdate         DATE,
    create_date       DATE
);


-- ============================================================
-- Create dim_products
-- ============================================================

CREATE TABLE gold.dim_products (
    product_key       INTEGER,
    product_id        INTEGER,
    product_number    VARCHAR(50),
    product_name      VARCHAR(50),
    category_id       VARCHAR(50),
    category          VARCHAR(50),
    subcategory       VARCHAR(50),
    maintenance       VARCHAR(50),
    cost              INTEGER,
    product_line      VARCHAR(50),
    start_date        DATE
);


-- ============================================================
-- Create fact_sales
-- ============================================================

CREATE TABLE gold.fact_sales (
    order_number      VARCHAR(50),
    product_key       INTEGER,
    customer_key      INTEGER,
    order_date        DATE,
    shipping_date     DATE,
    due_date          DATE,
    sales_amount      INTEGER,
    quantity          SMALLINT,
    price             INTEGER
);

TRUNCATE TABLE gold.dim_customers;

\copy gold.dim_customers FROM '/Users/martyna/Documents/sql/sql-data-analytics-project/datasets/flat-files/dim_customers.csv' WITH (FORMAT CSV, HEADER TRUE, DELIMITER ',');


TRUNCATE TABLE gold.dim_products;

\copy gold.dim_products FROM '/Users/martyna/Documents/sql/sql-data-analytics-project/datasets/flat-files/dim_products.csv' WITH (FORMAT CSV, HEADER TRUE, DELIMITER ',');


TRUNCATE TABLE gold.fact_sales;

\copy gold.fact_sales FROM '/Users/martyna/Documents/sql/sql-data-analytics-project/datasets/flat-files/fact_sales.csv' WITH (FORMAT CSV, HEADER TRUE, DELIMITER ',');