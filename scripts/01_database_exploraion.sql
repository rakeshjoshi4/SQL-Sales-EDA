-- Explore all Objects in the Database

SELECT * FROM INFORMATION_SCHEMA.TABLES;

-- Explore all Columns in the Database

-- For Customers Table
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers';

-- For Products Table
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_products';

-- For Sales Table
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'fact_sales';