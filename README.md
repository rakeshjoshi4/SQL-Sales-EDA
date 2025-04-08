# SQL Exploratory Data Analysis (EDA) Project

## Overview

This project demonstrates exploratory data analysis (EDA) using Microsoft SQL Server on a data warehouse to analyze sales, customer demographics, and product performance. The analysis uses SQL to explore, analyze, and derive insights from structured data.

## Features

* Database Exploration: Understanding the structure of tables and columns.
* Dimension Exploration: Analyzing categorical data like countries and product categories.
* Date Range Analysis: Identifying temporal patterns in sales and customer demographics.
* Measures Exploration: Calculating key business metrics such as total sales and average price.
* Magnitude Analysis: Aggregating data by dimensions like country and category.
* Ranking Analysis: Identifying top-performing products and customers.

## Dataset Description

### Tables

- `dim_customers`: Contains customer demographics such as name, country, gender, and birthdate.
- `dim_products`: Includes product details such as category, subcategory, cost, and product line.
- `fact_sales`: Stores transactional data including order details, sales amount, quantity sold, and dates.

### Key Columns

- `customer_key`: Unique identifier for customers.
- `product_key`: Unique identifier for products.
- `sales_amount`: Total revenue generated per transaction.

## Getting Started

### Prerequisites

Ensure you have:
- Microsoft SQL Server or a compatible database management system.
- Access to the dataset files (CSV format) for customers, products, and sales.

### Installation Instructions

1.  **Clone the Repository:**

    ```
    git clone https://github.com/rakeshjoshi4/SQL-Sales-EDA.git
    ```

2.  **Open SQL Scripts:**

    *   Open your preferred database management tool (e.g., Microsoft SQL Server Management Studio).
    *   Open the SQL scripts located in the `scripts` directory.

3.  **Initialize the Database and Load Data:**

    *   Execute the `00_init_database.sql` script to create the database, define the schema, and create the tables.
    *   Import the data from the CSV files (`gold.dim_customers.csv`, `gold.dim_products.csv`, and `gold.fact_sales.csv`) into their respective tables. You can use SQL Server Management Studio's import wizard or `BULK INSERT` statements.



## Key SQL Queries

### Database Exploration

1. **Explore all tables in the database**
```sql
SELECT * FROM INFORMATION_SCHEMA.TABLES;
```

2. **Explore columns in the 'dim_customers' table**
```sql
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'dim_customers';
```

### Dimension Exploration

1. **Explore all countries where customers come from**
```sql
SELECT DISTINCT Country FROM gold.dim_customers ORDER BY Country;
```

2. **Explore product categories**
```sql
SELECT DISTINCT category FROM gold.dim_products ORDER BY category;
```

### Date Range Analysis

1. **Find the date range of orders**
```sql
SELECT
MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date,
DATEDIFF(year, MIN(order_date), MAX(order_date)) AS order_range_in_years
FROM
gold.fact_sales;
```

2. **Find the youngest and oldest customer**
```sql
SELECT 
MIN(birthdate) AS oldest_customer,
DATEDIFF(year, MIN(birthdate), GETDATE()) AS oldest_age,
MAX(birthdate) AS youngest_customer,
DATEDIFF(year, MAX(birthdate), GETDATE()) AS youngest_age
FROM 
gold.dim_customers;
```

### Measures Exploration

1. **Calculate total sales revenue**
```sql
SELECT SUM(sales_amount) AS total_sales FROM gold.fact_sales;
```

2. **Generate a report of key business metrics**
```sql
SELECT 'Total sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Average Price', AVG(price) FROM gold.fact_sales
UNION ALL 
SELECT 'Total no. Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total no. Products', COUNT(product_name) FROM gold.dim_products
UNION ALL
SELECT 'Total no. Customers', COUNT(customer_key) FROM gold.dim_customers;
```

### Magnitude Analysis

1. **Find total customers by countries**
```sql
SELECT country, COUNT(customer_key) AS total_customers
FROM gold.dim_customers
GROUP BY country
ORDER BY total_customers DESC;
```

2. **What is the average costs in each category**
```sql
SELECT category, AVG(cost) AS avg_costs
FROM gold.dim_products
GROUP BY category
ORDER BY avg_costs DESC;
```

### Ranking Analysis

1. **Top 5 products by revenue**
```sql
SELECT TOP 5 p.product_name, SUM(f.sales_amount) AS highest_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY highest_revenue DESC;
```

2. **Top 10 customers by revenue generated**
```sql
SELECT TOP 10 c.first_name, c.last_name, SUM(f.sales_amount) AS highest_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c ON c.customer_key = f.customer_key
GROUP BY c.first_name, c.last_name
ORDER BY highest_revenue DESC;
```

## Findings

The SQL EDA project provided several actionable insights:

1. **Key Metrics**:
   - Total sales revenue was calculated to provide a high-level overview of business performance.
   - Average selling price and total orders gave insights into customer purchasing behavior and sales efficiency.

2. **Top Performers**:
   - Top 5 products by revenue help in strategic product placement and marketing efforts.
   - Top 10 customers by revenue indicate key accounts that require special attention and retention strategies.

3. **Demographic Insights**:
   - Customer distribution across countries helps tailor marketing strategies based on regional preferences.
   - Gender-based analysis refines marketing campaigns for specific demographics.

4. **Temporal Insights**:
   - Analyzing the date range of sales orders provides an understanding of sales trends over time for forecasting.

5. **Product Category Analysis**:
   - Understanding which product categories are most popular can inform decisions about product development and inventory management.

6. **Customer Segmentation**:
   - Grouping customers by order frequency and revenue generation helps create targeted marketing campaigns and loyalty programs.

## Conclusion

The SQL Exploratory Data Analysis project successfully extracted meaningful insights from structured data stored in a relational database. These findings can inform strategic decisions related to product management, marketing strategies, customer segmentation, and operational efficiency. The use of Microsoft SQL Server allowed efficient querying and manipulation of large datasets to uncover valuable business intelligence.

## Recommendations

Based on the analysis:

1. **Product Strategy**: Focus marketing on top-performing products and consider strategies to improve sales of underperforming items.
2. **Customer Engagement**: Develop loyalty programs for top customers and target marketing to increase engagement from infrequent buyers.
3. **Geographic Focus**: Tailor marketing efforts to high-customer-density countries and explore opportunities in under-tapped regions.
4. **Category Performance**: Prioritize and optimize product categories based on average costs and revenue contribution.

