SELECT *
FROM `bigquery-public-data.thelook_ecommerce.order_items`
LIMIT 10;

SELECT *
FROM `bigquery-public-data.thelook_ecommerce.orders`
LIMIT 10;

SELECT *
FROM `bigquery-public-data.thelook_ecommerce.users`
LIMIT 10;

SELECT *
FROM `bigquery-public-data.thelook_ecommerce.products`
LIMIT 10;

/*1. Top Customers by Revenue Query */
SELECT 
  user_id,
  COUNT(order_id) AS total_orders,
  SUM(sale_price) AS total_revenue
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE status = 'Complete'
GROUP BY user_id
ORDER BY total_revenue DESC
LIMIT 10;
/* Insight:
Small group of users generate high revenue
Opportunity for retention strategies.   */


/*2. Category Performance Query */
SELECT 
  p.category,
  COUNT(*) AS total_orders,
  SUM(oi.sale_price) AS total_revenue
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
JOIN `bigquery-public-data.thelook_ecommerce.products` p
ON oi.product_id = p.id
WHERE oi.status = 'Complete'
GROUP BY p.category
ORDER BY total_revenue DESC
LIMIT 10;
/* Insight:
Certain product categories dominate revenue
Helps guide inventory planning.    */


/*3. Top Products by Revenue Query */
SELECT 
  p.name AS product_name,
  p.category,
  p.brand,
  oi.product_id,
  COUNT(*) AS total_orders,
  SUM(oi.sale_price) AS total_revenue
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
JOIN `bigquery-public-data.thelook_ecommerce.products` p
ON oi.product_id = p.id
WHERE oi.status = 'Complete'
GROUP BY p.name, p.category, p.brand, oi.product_id
ORDER BY total_revenue DESC
LIMIT 10;
/*Insight:
Revenue concentrated among top products
High demand for limited SKUs.   */

/*4. User-to-Order Conversion Summary Query*/
SELECT 
  COUNT(DISTINCT u.id) AS total_users,
  COUNT(DISTINCT o.order_id) AS total_orders,
  COUNT(DISTINCT CASE WHEN oi.status = 'Complete' THEN oi.order_id END) AS completed_orders
FROM `bigquery-public-data.thelook_ecommerce.users` u
LEFT JOIN `bigquery-public-data.thelook_ecommerce.orders` o
ON u.id = o.user_id
LEFT JOIN `bigquery-public-data.thelook_ecommerce.order_items` oi
ON o.order_id = oi.order_id
LIMIT 10;
/*Purpose:
Measure user base size, total orders, and completed orders to understand overall 
user-to-order conversion.

Insight:
Only 31,277 out of 125,066 orders were completed → low fulfillment success
Average orders per user ≈ 1.25, indicating low repeat purchase behavior
Only ~31% of users placed completed orders, suggesting weak conversion from user base to successful customers
Large gap between total orders and completed orders indicates operational drop-offs in order lifecycle
Business opportunity exists to improve customer retention and order completion rate.   */

/*5. Conversion funnel */
SELECT
  status,
  COUNT(DISTINCT order_id) AS orders
FROM `bigquery-public-data.thelook_ecommerce.order_items`
GROUP BY status
ORDER BY orders DESC;
/* Insight:
Majority of orders remain in shipped and processing stages
Only 25.01% orders completed
High cancellation and return volume indicates funnel leakage.  */


/*6. Conversion Rate Query*/
SELECT
  COUNT(DISTINCT CASE WHEN status = 'Complete' THEN order_id END) * 100.0 /
  COUNT(DISTINCT order_id) AS conversion_rate
FROM `bigquery-public-data.thelook_ecommerce.order_items`;
/*Insight:
Overall conversion rate is 25.01%
Only one out of four orders gets completed.    */


/*7. Average Order Value (AOV) Query*/
SELECT
  ROUND(SUM(sale_price) / COUNT(DISTINCT order_id),2) AS avg_order_value
FROM `bigquery-public-data.thelook_ecommerce.order_items`
WHERE status = 'Complete';
/*Insight:
Average Order Value is $85.94
Revenue growth depends more on improving conversion rate.   */


/*8. Return Rate Query*/
SELECT
  COUNT(DISTINCT CASE WHEN status='Returned' THEN order_id END) * 100.0 /
  COUNT(DISTINCT order_id) AS return_rate
FROM `bigquery-public-data.thelook_ecommerce.order_items`;
/*Insight:
Return rate is 9.91%
Returns contribute to revenue loss.   */


