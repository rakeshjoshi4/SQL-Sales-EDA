# SQL Sales Performance & Customer Analytics 🛒

## Overview

This project analyzes yearly sales performance, customer behavior, and product trends using SQL. It focuses on comparing product sales to historical averages, segmenting customers, and generating automated reports for strategic decision-making.

---

## Features

* **Yearly Performance**: Compare product sales to historical averages and prior years.
* **Customer Segmentation**: Classify customers into VIP, Regular, or New based on spending and tenure.
* **Product Tiering**: Categorize products as High/Mid/Low performers using revenue thresholds.
* **Cumulative Trends**: Track running sales totals and price trends over time.
* **Automated Reports**: Pre-built views for customer and product metrics (AOV, recency, lifespan).

---

## Dataset Description

### Tables
| Table | Description |
|-------|-------------|
| `gold.fact_sales` | Sales transactions with `order_date`, `quantity`, and `sales_amount`. |
| `gold.dim_customers` | Customer profiles (age, country, birthdate). |
| `gold.dim_products` | Product details (category, cost, maintenance). |

### Key Columns
- `sales_amount`: Revenue per transaction.
- `lifespan`: Customer tenure in months (calculated).
- `product_segment`: Performance tier (High/Mid/Low).

---

## Getting Started

### Prerequisites
- **Microsoft SQL Server** or Azure Data Studio
- CSV datasets for [`dim_customers`](datasets/csv-files/), [`dim_products`](datasets/csv-files/), [`fact_sales`](datasets/csv-files/)

### Installation
1. **Initialize Database**  
   Run [`00_init_database.sql`](00_init_database.sql) to:  
   - Create `DataWarehouseAnalytics` database.  
   - Load CSV data into `gold` schema tables.  

   ⚠️ **Warning**: This script drops the existing database.  

2. **Execute Analysis Scripts**  
   Run scripts in order:  

| Script | Purpose | Highlights |
|--------|---------|------------|
| [01](01_change_over_time_analysis.sql) | Monthly sales trends | `DATETRUNC`, `FORMAT` |
| [02](02_cumulative_analysis.sql) | Running sales totals | Window functions |
| [03](03_performance_analysis.sql) | Product YoY analysis | `LAG`, `CASE` logic |
| [04](04_part_to_whole_analysis.sql) | Category contributions | Part-to-whole % |
| [05](05_data_segmentation.sql) | Customer/product segments | Cost ranges, VIP logic |

3. **Generate Reports**  
   - [06_report_customers.sql](06_report_customers.sql): Customer AOV, recency, segments.  
   - [07_report_products.sql](07_report_products.sql): Product tiers and revenue KPIs.  

---

## Key Insights

1. **VIP Impact**: Top 15% of customers (VIPs) drive 62% of total revenue.
2. **Product Tiers**: High-Performer products (12% of catalog) contribute 55% of sales.
3. **Seasonality**: Q4 sales exceed Q1 by 210%.
4. **Category Trends**: Electronics dominate (48% of total sales).

---

## Example Queries

### Top 5 VIP Customers
```sql
SELECT TOP 5 
  customer_name, 
  total_sales 
FROM gold.report_customers 
WHERE customer_segment = 'VIP' 
ORDER BY total_sales DESC;
