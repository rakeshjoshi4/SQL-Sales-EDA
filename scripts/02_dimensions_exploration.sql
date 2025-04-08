-- Explore all Countries our customers come from

SELECT DISTINCT Country FROM gold.dim_customers
ORDER BY Country;

-- Explore all Category "The Major Division"

SELECT DISTINCT category, subcategory, product_name FROM gold.dim_products
ORDER BY 1, 2, 3;