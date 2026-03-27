# E-Commerce Sales Performance Dashboard

## Overview
This project analyzes e-commerce sales data using SQL in Google BigQuery and builds an interactive Excel dashboard to support data-driven decision-making.

## Tools Used
- Google BigQuery (SQL)
- Microsoft Excel
- Power Query
- Pivot Tables & Charts

## Dataset
Source: bigquery-public-data.thelook_ecommerce

Tables:
- orders
- order_items
- users
- products

## Key KPIs
- Conversion Rate: 25.01%
- Average Order Value: $85.94
- Return Rate: 9.91%
- Total Users: 100,000
- Completed Orders: 31,277

## Dashboard Features
- Revenue Trend Over Time
- Revenue by Order Status
- Order Funnel
- Top Products by Revenue
- Revenue by Department
- Interactive Slicers & Timeline

## SQL Analysis & Insights

### Conversion Funnel Query
Shows order distribution across lifecycle stages.
Insight: Only 25.01% orders completed, indicating major drop-offs.

### Conversion Rate Query
Insight: Low order completion efficiency.

### Average Order Value (AOV)
Insight: Average spend per order is $85.94.

### Return Rate Query
Insight: 9.91% orders returned impacting revenue.

### Top Customers Query
Insight: Revenue concentrated among small user group.

### Category Performance Query
Insight: Few categories drive majority of revenue.

### Top Products Query
Insight: Sales concentrated in top-performing products.

### User-to-Order Conversion Query
Insight: 100K users generated 125,066 orders but only 31,277 completed.

## Project Structure
dashboard/ → Excel dashboard  
sql/ → SQL queries  

## Author
Aarati Kuchekar
