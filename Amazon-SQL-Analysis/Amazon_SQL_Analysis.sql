-- ============================================================
-- AMAZON INDIA SALES ANALYSIS
-- SQL PORTFOLIO PROJECT
-- ============================================================
-- Database: amazon_sales
-- Table: amazon_orders
-- Purpose: Business-focused sales, customer, product and seller analysis
-- ============================================================

USE amazon_sales;

-- ============================================================
-- Q01 - Overall Sales Performance
-- ============================================================

SELECT 
COUNT(*) AS total_orders,
SUM(Quantity) AS total_unit_sold,
ROUND(SUM(TotalAmount),2) AS total_sales,
ROUND(AVG(TotalAmount),2) AS average_order_value
FROM amazon_orders;

-- ============================================================
-- Q02 - Monthly Sales Trend
-- ============================================================

SELECT
YEAR(OrderDate) AS order_year,
MONTH(OrderDate) AS order_month,
ROUND(SUM(TotalAmount),2) AS total_sales,
COUNT(*) AS total_orders
FROM amazon_orders
GROUP BY YEAR(OrderDate),MONTH(OrderDate)
ORDER BY order_year,order_month;

-- ============================================================
-- Q03 - Category Sales Performance
-- ============================================================

SELECT 
Category,
COUNT(*) AS total_orders,
SUM(Quantity) AS units_sold,
ROUND(SUM(TotalAmount),2) AS total_sales
FROM amazon_orders
GROUP BY Category
ORDER BY  total_sales DESC;

-- ============================================================
-- Q04 - Top 10 Products by Sales
-- ============================================================

SELECT 
ProductName,Category,
SUM(Quantity) AS units_sold,
COUNT(*) AS total_orders,
ROUND(SUM(TotalAmount),2) AS total_sales
FROM amazon_orders
GROUP BY ProductName,Category
ORDER BY total_sales DESC
LIMIT 10;

-- ============================================================
-- Q05 - Brand Sales Performance
-- ============================================================

SELECT
Brand,
COUNT(*) AS total_orders,
SUM(Quantity) AS units_sold,
ROUND(SUM(TotalAmount),2) AS total_sales
FROM amazon_orders
GROUP BY Brand
ORDER BY total_sales DESC;

-- ============================================================
-- Q06 - Payment Method Usage
-- ============================================================

SELECT 
PaymentMethod,
COUNT(*) AS total_orders,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM amazon_orders),2) AS order_percentage
FROM amazon_orders
GROUP BY PaymentMethod 
ORDER BY total_orders DESC;

-- ============================================================
-- Q07 - Order Status Distribution
-- ============================================================

SELECT 
OrderStatus, 
COUNT(*) AS total_orders,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM amazon_orders),2) AS order_percentage
FROM amazon_orders
GROUP BY OrderStatus
ORDER BY total_orders DESC;

-- ============================================================
-- Q08 - State-wise Sales Performance
-- ============================================================

SELECT
State,
COUNT(*) AS total_orders,
ROUND(SUM(TotalAmount),2) AS total_sales
FROM amazon_orders
GROUP BY State
ORDER BY total_sales DESC;

-- ============================================================
-- Q09 - Repeat Customer Performance
-- ============================================================

SELECT 
CustomerID,CustomerName,
COUNT(*) AS total_orders,
SUM(Quantity) AS units_purchased,
ROUND(SUM(TotalAmount),2) AS total_spent
FROM amazon_orders
GROUP BY CustomerID,CustomerName
HAVING COUNT(*) >3;

-- ============================================================
-- Q10 - Order Value Segmentation
-- ============================================================

SELECT 
CASE
WHEN TotalAmount < 10000 THEN 'Low Value'
WHEN TotalAmount < 30000 THEN 'Medium Value'
ELSE 'High Value'
END AS order_segment,
COUNT(*) AS total_orders,
ROUND(SUM(TotalAmount),2) AS total_sales,
ROUND(AVG(TotalAmount),2) AS average_order_value
FROM amazon_orders 
GROUP BY order_segment
ORDER BY total_sales DESC;

-- ============================================================
-- Q11 - Customers Spending Above the Average
-- ============================================================

SELECT 
CustomerID,CustomerName,
ROUND(SUM(TotalAmount),2) AS total_spent
FROM amazon_orders
GROUP BY CustomerID,CustomerName
HAVING SUM(TotalAmount) > (SELECT AVG(customer_spend) FROM (SELECT SUM(TotalAmount) AS customer_spend
FROM amazon_orders
GROUP BY CustomerID ) AS customer_totals)
ORDER BY total_spent DESC;

-- ============================================================
-- Q12 - Month-over-Month Sales Growth
-- ============================================================

WITH monthly_sales AS (
SELECT
YEAR(OrderDate) AS order_year,
MONTH(OrderDate) AS order_month,
ROUND(SUM(TotalAmount), 2) AS monthly_sales
FROM amazon_orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate))
SELECT
order_year,order_month,monthly_sales,
LAG(monthly_sales) OVER (
ORDER BY order_year, order_month) AS previous_month_sales,
ROUND((monthly_sales - LAG(monthly_sales) OVER (
ORDER BY order_year, order_month)) * 100.0 /
NULLIF(LAG(monthly_sales) OVER (ORDER BY order_year, order_month), 0),2) AS sales_growth_percentage
FROM monthly_sales
ORDER BY order_year, order_month;

-- ============================================================
-- Q13 - New Customer Acquisition Trend
-- ============================================================

WITH first_purchase AS (
SELECT 
CustomerID,MIN(OrderDate) AS first_order_date
FROM amazon_orders
GROUP BY CustomerID )
SELECT 
YEAR(first_order_date) AS order_year,
MONTH(first_order_date) AS order_month,
COUNT(*) AS new_customers
FROM first_purchase
GROUP BY YEAR(first_order_date),MONTH(first_order_date)
ORDER BY order_year,order_month;

-- ============================================================
-- Q14 - Discount Level and Sales Performance
-- ============================================================

SELECT 
Discount,
COUNT(*) AS total_orders,
ROUND(AVG(TotalAmount),2) AS average_order_value,
ROUND(SUM(TotalAmount),2) AS total_sales
FROM amazon_orders
GROUP BY Discount
ORDER BY Discount;

-- ============================================================
-- Q15 - Day-of-Week Sales Performance
-- ============================================================

SELECT
DAYNAME(OrderDate) AS order_day,
COUNT(*) AS total_orders,
SUM(Quantity) AS units_sold,
ROUND(SUM(TotalAmount),2) AS total_sales
FROM amazon_orders
GROUP BY DAYOFWEEK(OrderDate),DAYNAME(OrderDate)
ORDER BY total_sales DESC;

-- ============================================================
-- Q16 - High Shipping-Cost Orders
-- ============================================================

SELECT 
COUNT(*) AS high_shipping_orders,
ROUND(SUM(ShippingCost),2) AS total_shipping_cost,
ROUND(SUM(TotalAmount),2) AS associated_sales
FROM amazon_orders
WHERE ShippingCost > (
SELECT AVG(ShippingCost)
FROM amazon_orders );

-- ============================================================
-- Q17 - Category Cancellation Rate
-- ============================================================

SELECT Category,
COUNT(*) AS total_orders,
SUM(OrderStatus='Cancelled') AS cancelled_orders,
ROUND(SUM(OrderStatus='Cancelled')*100.0 / COUNT(*),2) AS cancellation_rate
FROM amazon_orders
GROUP BY Category
ORDER BY cancellation_rate DESC;

-- ============================================================
-- Q18 - Category Return Rate
-- ============================================================

SELECT Category,
COUNT(*) AS total_orders,
SUM(OrderStatus='Returned') AS returned_orders,
ROUND(SUM(OrderStatus='Returned')*100.0 / COUNT(*),2) AS returned_rate
FROM amazon_orders
GROUP BY Category
ORDER BY returned_rate DESC;

-- ============================================================
-- Q19 - Products with the Highest Returns
-- ============================================================

SELECT ProductName,Category,
SUM(OrderStatus = 'Returned') AS returned_orders,
SUM(Quantity * (OrderStatus = 'Returned')) AS returned_units
FROM amazon_orders
GROUP BY ProductName, Category
HAVING returned_orders > 0
ORDER BY returned_orders DESC
LIMIT 10;

-- =========================================================
-- Q20 - Customer Purchase Frequency & Repeat Customer Analysis
-- =========================================================

WITH customer_orders AS (
SELECT
CustomerID,
COUNT(DISTINCT OrderID) AS total_orders,
ROUND(SUM(TotalAmount), 2) AS total_spent
FROM amazon_orders
GROUP BY CustomerID),

customer_segments AS (
SELECT
CustomerID,total_orders,total_spent,
CASE
WHEN total_orders = 1 THEN 'One-Time Customer'
WHEN total_orders BETWEEN 2 AND 3 THEN 'Occasional Customer'
WHEN total_orders BETWEEN 4 AND 6 THEN 'Repeat Customer'
ELSE 'Loyal Customer'
END AS customer_segment
FROM customer_orders)
SELECT
customer_segment,
COUNT(*) AS customer_count,
ROUND(AVG(total_orders), 2) AS avg_orders_per_customer,
ROUND(AVG(total_spent), 2) AS avg_customer_spend,
ROUND(SUM(total_spent), 2) AS segment_total_sales
FROM customer_segments
GROUP BY customer_segment
ORDER BY segment_total_sales DESC;

-- ============================================================
-- Q21 - Top-Selling Product in Each Category
-- ============================================================

WITH product_sales AS (
SELECT
Category,ProductName,
ROUND(SUM(TotalAmount), 2) AS total_sales
FROM amazon_orders
GROUP BY Category, ProductName),
ranked_products AS (
SELECT
Category,ProductName,total_sales,
ROW_NUMBER() OVER (
PARTITION BY Category
ORDER BY total_sales DESC) AS product_rank
FROM product_sales)
SELECT
Category,ProductName,total_sales
FROM ranked_products
WHERE product_rank = 1
ORDER BY total_sales DESC;

-- ============================================================
-- Q22 - State Sales Contribution
-- ============================================================

SELECT
State,
ROUND(SUM(TotalAmount),2) AS state_sales,
ROUND(SUM(TotalAmount) *100.0/SUM(SUM(TotalAmount)) OVER (),2) AS sales_contribution_pct
FROM amazon_orders
GROUP BY State
ORDER BY sales_contribution_pct DESC;

-- ============================================================
-- Q23 - City with the Highest Number of Orders
-- ============================================================

WITH city_orders AS (
SELECT
City,
COUNT(*) AS total_orders
FROM amazon_orders
GROUP BY City),
ranked_cities AS (
SELECT
City,total_orders,
DENSE_RANK() OVER (
ORDER BY total_orders DESC) AS city_rank
FROM city_orders)
SELECT
City,total_orders,city_rank
FROM ranked_cities;

-- ============================================================
-- Q24 - Seller Performance Groups
-- ============================================================

WITH seller_sales AS (
SELECT
SellerID,
ROUND(SUM(TotalAmount), 2) AS total_sales
FROM amazon_orders
GROUP BY SellerID),
seller_rank AS (
SELECT
SellerID,total_sales,
ROW_NUMBER() OVER (
ORDER BY total_sales DESC) AS seller_rank
FROM seller_sales)
SELECT
SellerID,total_sales,seller_rank,
CEIL(seller_rank / 10.0) AS performance_group
FROM seller_rank
WHERE seller_rank <= 40
ORDER BY performance_group, seller_rank;

-- ============================================================
-- Q25 - High-Sales Sellers with High Return Rates
-- ============================================================

WITH seller_performance AS (
SELECT
SellerID,
ROUND(SUM(TotalAmount), 2) AS total_sales,
COUNT(*) AS total_orders,
SUM(OrderStatus = 'Returned') AS returned_orders
FROM amazon_orders
GROUP BY SellerID)
SELECT
SellerID,total_orders,returned_orders,total_sales,
ROUND(returned_orders * 100.0 / total_orders, 2) AS return_rate
FROM seller_performance
WHERE total_sales > (
SELECT AVG(total_sales)
FROM seller_performance)
AND returned_orders * 100.0 / total_orders > 5
ORDER BY return_rate DESC, total_sales DESC;
-- ============================================================
-- END OF PROJECT
-- ============================================================
