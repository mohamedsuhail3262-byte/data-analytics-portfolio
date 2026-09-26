# Amazon E-Commerce Sales Analysis using SQL

## Project Overview

This project focuses on analyzing Amazon India e-commerce sales data using SQL.

The analysis explores sales performance, customer behavior, products, brands, payment methods, order status, geographical performance, and seller performance.

The project contains 25 business-focused SQL analyses covering different sales, customer, product, operational, geographical, and seller-related business questions.

---

## Project Objectives

- Analyze overall sales and order performance
- Identify sales trends over time
- Compare category and brand performance
- Identify top-performing products
- Understand customer purchasing behavior
- Analyze payment method usage
- Study order status distribution
- Compare sales across states and cities
- Analyze seller performance
- Identify high-value customers and orders
- Analyze return and cancellation behavior
- Analyze shipping cost patterns
- Generate business-oriented insights using SQL

---

## Dataset

The dataset contains Amazon India order-level transaction data.

### Key Columns

- OrderID
- OrderDate
- CustomerID
- CustomerName
- ProductID
- ProductName
- Category
- Brand
- Quantity
- UnitPrice
- Discount
- Tax
- ShippingCost
- TotalAmount
- PaymentMethod
- OrderStatus
- City
- State
- Country
- SellerID

The dataset includes order statuses such as Delivered, Shipped, Pending, Cancelled, and Returned.

---

## Database Details

**Database:** `amazon_sales`

**Table:** `amazon_orders`

The SQL analysis is designed around the `amazon_orders` table.

---

## SQL Analysis

The project contains 25 business-focused SQL questions covering different sales, customer, product, operational, geographical, and seller-related business questions.

- Q01 – Overall Sales Performance
- Q02 – Monthly Sales Trend
- Q03 – Category Sales Performance
- Q04 – Top 10 Products by Sales
- Q05 – Brand Sales Performance
- Q06 – Payment Method Usage
- Q07 – Order Status Distribution
- Q08 – State-wise Sales Performance
- Q09 – Repeat Customer Performance
- Q10 – Order Value Segmentation
- Q11 – Customers Spending Above the Average
- Q12 – Month-over-Month Sales Growth
- Q13 – New Customer Acquisition Trend
- Q14 – Discount Level and Sales Performance
- Q15 – Day-of-Week Sales Performance
- Q16 – High Shipping-Cost Orders
- Q17 – Category Cancellation Rate
- Q18 – Category Return Rate
- Q19 – Products with the Highest Returns
- Q20 – Customer Purchase Frequency & Repeat Customer Analysis
- Q21 – Top-Selling Product in Each Category
- Q22 – State Sales Contribution
- Q23 – City with the Highest Number of Orders
- Q24 – Seller Performance Groups
- Q25 – High-Sales Sellers with High Return Rates

---

## SQL Skills Demonstrated

- SELECT
- WHERE
- GROUP BY
- HAVING
- ORDER BY
- LIMIT
- Aggregate Functions
- CASE Statements
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions
- ROW_NUMBER()
- DENSE_RANK()
- LAG()
- PARTITION BY
- Ranking Techniques
- Date Functions
- Percentage Calculations
- Month-over-Month Analysis
- Customer Segmentation
- Sales Contribution Analysis
- Return Rate Analysis
- Cancellation Rate Analysis
- Seller Performance Analysis

---

## Business Areas Covered

### Sales Analysis

- Overall sales performance
- Average order value
- Monthly sales trends
- Category performance
- Product performance
- Brand performance
- Sales contribution

### Customer Analysis

- Repeat customers
- Customer spending
- Customer purchase frequency
- Customer segmentation
- New customer acquisition

### Product Analysis

- Top-selling products
- Product performance by category
- Product return analysis
- Product sales performance

### Geographic Analysis

- State-wise sales
- State sales contribution
- City-wise order performance

### Seller Analysis

- Seller sales performance
- Seller ranking
- Seller performance groups
- High-sales sellers with high return rates

### Operational Analysis

- Order status distribution
- Payment method usage
- Order value segmentation
- Shipping cost analysis
- Cancellation rate
- Return rate

---

## Data Validation

A separate SQL validation file is included to perform data quality and consistency checks.

The validation file includes checks for:

- Table existence
- Table structure
- Total row count
- NULL values
- Duplicate Order IDs
- Exact duplicate rows
- Date range
- Invalid or future dates
- Numeric value ranges
- Data quality issues

The validation queries are separate from the 25 business analysis questions.

---

## Project Workflow

1. Import the Amazon sales dataset
2. Create the `amazon_sales` database
3. Create and populate the `amazon_orders` table
4. Run the data validation queries
5. Execute the 25 SQL analysis queries
6. Review the results
7. Interpret the results from a business perspective

---

## Project Files

- `Amazon_SQL_Analysis.sql` – Main SQL analysis containing 25 business questions
- `Amazon_SQL_Validation.sql` – Data validation and quality check queries
- `Amazon_Sales_Dataset.csv` – Amazon India sales dataset
- `README.md` – Project documentation

---

## Project Structure

    Amazon-SQL-Analysis/
    │
    ├── Amazon_SQL_Analysis.sql
    ├── Amazon_SQL_Validation.sql
    ├── Amazon_Sales_Dataset.csv
    └── README.md

---

## Project Outcome

This project demonstrates how SQL can be used to transform raw e-commerce order data into meaningful business analysis.

The project covers sales, customers, products, geography, sellers, payments, returns, cancellations, and order operations using practical SQL techniques.

It demonstrates the ability to:

- Analyze e-commerce order data
- Write structured SQL queries
- Apply aggregation and filtering techniques
- Use subqueries and CTEs
- Apply window functions and ranking techniques
- Perform customer and seller analysis
- Analyze returns and cancellations
- Validate data quality
- Translate data into business-focused insights

---

## Conclusion

This project provides practical experience in using SQL for end-to-end e-commerce data analysis.

By working with sales, customer, product, geographical, operational, and seller data, the project demonstrates how SQL can be applied to answer real-world business questions.

The combination of business-focused analysis and data validation makes this project suitable for demonstrating SQL and analytical skills in a Data Analyst portfolio.
