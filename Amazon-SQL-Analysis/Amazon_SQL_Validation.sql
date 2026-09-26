-- ================================================================
-- AMAZON INDIA SALES ANALYSIS
-- DATA VALIDATION & QUALITY CHECKS
-- ================================================================
--
-- Database : amazon_sales
-- Table    : amazon_orders
-- Purpose  : Validate data quality before business analysis
--
-- This file is separate from the main Q01-Q25 analysis file.
-- Validation checks are NOT counted as business questions.
-- ================================================================

USE amazon_sales;

-- ================================================================
-- 01. TABLE EXISTENCE CHECK
-- ================================================================

SHOW TABLES;

-- ================================================================
-- 02. TABLE STRUCTURE CHECK
-- ================================================================

DESCRIBE amazon_orders;

-- ================================================================
-- 03. TOTAL ROW COUNT CHECK
-- ================================================================

SELECT
COUNT(*) AS total_rows
FROM amazon_orders;

-- ================================================================
-- 04. NULL VALUE CHECK
-- ================================================================

SELECT
SUM(OrderID IS NULL) AS null_order_id,
SUM(OrderDate IS NULL) AS null_order_date,
SUM(CustomerID IS NULL) AS null_customer_id,
SUM(CustomerName IS NULL) AS null_customer_name,
SUM(ProductID IS NULL) AS null_product_id,
SUM(ProductName IS NULL) AS null_product_name,
SUM(Category IS NULL) AS null_category,
SUM(Brand IS NULL) AS null_brand,
SUM(Quantity IS NULL) AS null_quantity,
SUM(UnitPrice IS NULL) AS null_unit_price,
SUM(Discount IS NULL) AS null_discount,
SUM(Tax IS NULL) AS null_tax,
SUM(ShippingCost IS NULL) AS null_shipping_cost,
SUM(TotalAmount IS NULL) AS null_total_amount,
SUM(PaymentMethod IS NULL) AS null_payment_method,
SUM(OrderStatus IS NULL) AS null_order_status,
SUM(City IS NULL) AS null_city,
SUM(State IS NULL) AS null_state,
SUM(Country IS NULL) AS null_country,
SUM(SellerID IS NULL) AS null_seller_id
FROM amazon_orders;

-- ================================================================
-- 05. DUPLICATE ORDER ID CHECK
-- ================================================================

SELECT
OrderID,
COUNT(*) AS duplicate_count
FROM amazon_orders
GROUP BY OrderID
HAVING COUNT(*) > 1;

-- ================================================================
-- 06. EXACT DUPLICATE ROW CHECK
-- ================================================================

SELECT
COUNT(*) AS total_rows,
COUNT(DISTINCT CONCAT_WS('|',
OrderID,
OrderDate,
CustomerID,
CustomerName,
ProductID,
ProductName,
Category,
Brand,
Quantity,
UnitPrice,
Discount,
Tax,
ShippingCost,
TotalAmount,
PaymentMethod,
OrderStatus,
City,
State,
Country,
SellerID)) AS unique_rows
FROM amazon_orders;

-- ================================================================
-- 07. DATE RANGE CHECK
-- ================================================================

SELECT
MIN(OrderDate) AS first_order_date,
MAX(OrderDate) AS last_order_date
FROM amazon_orders;

-- ================================================================
-- 08. INVALID / FUTURE DATE CHECK
-- ================================================================

SELECT
COUNT(*) AS invalid_date_records
FROM amazon_orders
WHERE OrderDate IS NULL OR OrderDate > CURRENT_DATE;

-- ================================================================
-- 09. NUMERIC RANGE CHECK
-- ================================================================

SELECT
MIN(Quantity) AS min_quantity,
MAX(Quantity) AS max_quantity,
MIN(UnitPrice) AS min_unit_price,
MAX(UnitPrice) AS max_unit_price,
MIN(Discount) AS min_discount,
MAX(Discount) AS max_discount,
MIN(Tax) AS min_tax,
MAX(Tax) AS max_tax,
MIN(ShippingCost) AS min_shipping_cost,
MAX(ShippingCost) AS max_shipping_cost,
MIN(TotalAmount) AS min_total_amount,
MAX(TotalAmount) AS max_total_amount
FROM amazon_orders;

-- ================================================================
-- 10. INVALID QUANTITY CHECK
-- ================================================================

SELECT
COUNT(*) AS invalid_quantity_records
FROM amazon_orders
WHERE Quantity <= 0;

-- ================================================================
-- 11. INVALID PRICE CHECK
-- ================================================================

SELECT
COUNT(*) AS invalid_price_records
FROM amazon_orders
WHERE UnitPrice <= 0;

-- ================================================================
-- 12. DISCOUNT VALUE CHECK
-- ================================================================

SELECT DISTINCT
Discount
FROM amazon_orders
ORDER BY Discount;

-- ================================================================
-- 13. INVALID DISCOUNT CHECK
-- ================================================================

SELECT
COUNT(*) AS invalid_discount_records
FROM amazon_orders
WHERE Discount < 0 OR Discount > 0.25;

-- ================================================================
-- 14. ORDER STATUS CHECK
-- ================================================================

SELECT DISTINCT
OrderStatus
FROM amazon_orders
ORDER BY OrderStatus;

-- ================================================================
-- 15. PAYMENT METHOD CHECK
-- ================================================================

SELECT DISTINCT
PaymentMethod
FROM amazon_orders
ORDER BY PaymentMethod;

-- ================================================================
-- VALIDATION COMPLETE
-- After validation, use amazon_sales_analysis.sql
-- for the 25 business-focused analysis questions.
-- ================================================================
