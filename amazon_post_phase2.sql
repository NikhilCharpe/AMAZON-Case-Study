/* AMAZON CASE STUDY - SQL ANALYSIS
 * SECTION 1 : DATABASE CHECK
 *
 * The comments above each query explain WHY the query is used and
 * WHAT BUSINESS INSIGHT can be obtained from its result.
 */

-- Connect to amazon_db before running this script.

/* Why: To verify which tables are available in the public schema before starting the analysis.
   Insight: Confirms that the required tables, such as customers, orders, and revenue, are present. */
-- Show Tables

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;

/* Why: To understand the structure of the customers table, including column names, data types, and NULL settings.
   Insight: Shows what customer information is available and how each field can be used in analysis. */
-- Describe customers
SELECT
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_name = 'customers'
ORDER BY ordinal_position;

/* Why: To inspect the structure and data types of the orders table before performing order and product analysis.
   Insight: Identifies fields available for analyzing products, quantities, prices, payment methods, and order status. */
-- Describe orders
SELECT
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_name = 'orders'
ORDER BY ordinal_position;

/* Why: To understand the structure of the revenue table and the fields available for financial analysis.
   Insight: Identifies the columns needed to analyze payments, revenue, payment status, and transaction values. */
-- Describe revenue
SELECT
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_name = 'revenue'
ORDER BY ordinal_position;


/*===========================================================*
 * SECTION 2 : DATA PREVIEW
 *===========================================================*/

/* Why: To inspect a small sample of customer records before performing analysis.
   Insight: Helps verify customer information such as names, cities, and membership tiers. */
SELECT *
FROM customers
LIMIT 10;

/* Why: To inspect sample order records and understand how order information is stored.
   Insight: Helps verify product category, quantity, price, payment method, and order status fields. */
SELECT *
FROM orders
LIMIT 10;

/* Why: To inspect sample revenue records and understand how payment information is stored.
   Insight: Helps validate amount paid and payment status before performing financial analysis. */
SELECT *
FROM revenue
LIMIT 10;


/*===========================================================*
 * SECTION 3 : RECORD COUNTS
 *===========================================================*/

/* Why: To calculate the total number of customers in the dataset.
   Insight: Shows the overall size of the Amazon customer base represented in the data. */
SELECT COUNT(*) AS total_customers
FROM customers;

/* Why: To calculate the total number of orders recorded in the dataset.
   Insight: Provides an overall measure of order volume and customer activity. */
SELECT COUNT(*) AS total_orders
FROM orders;

/* Why: To count the total number of payment/revenue records.
   Insight: Shows the volume of financial transactions and can be compared with order count to identify possible data gaps. */
SELECT COUNT(*) AS total_payments
FROM revenue;


/*===========================================================*
 * SECTION 4 : NULL CHECK
 *===========================================================*/

/* Why: To identify customer records where the email address is missing.
   Insight: Missing emails indicate a data-quality issue that may affect customer communication and marketing analysis. */
SELECT *
FROM customers
WHERE email IS NULL;

/* Why: To identify orders where the unit price is missing.
   Insight: Missing prices can affect revenue calculations, average price analysis, and product-level reporting. */
SELECT *
FROM orders
WHERE unit_price_usd IS NULL;

/* Why: To identify revenue records where the amount paid is missing.
   Insight: Missing payment amounts can lead to inaccurate total revenue and average transaction calculations. */
SELECT *
FROM revenue
WHERE amount_paid_usd IS NULL;


/*===========================================================*
 * SECTION 5 : BASIC ANALYSIS
 *===========================================================*/

/* Why: To identify all unique cities represented in the customer data.
   Insight: Shows the geographic coverage of the customer base. */
SELECT DISTINCT city
FROM customers;

/* Why: To identify all customer membership tiers available in the dataset.
   Insight: Helps understand the structure of customer segmentation. */
SELECT DISTINCT membership_tier
FROM customers;

/* Why: To identify all payment methods used for orders.
   Insight: Shows customer payment preferences and the available payment options. */
SELECT DISTINCT payment_method
FROM orders;

/* Why: To identify all order statuses present in the dataset.
   Insight: Helps understand the order lifecycle, such as delivered, pending, cancelled, or returned orders. */
SELECT DISTINCT order_status
FROM orders;

/* Why: To identify all payment statuses present in the revenue data.
   Insight: Helps understand the different outcomes of financial transactions. */
SELECT DISTINCT payment_status
FROM revenue;


/*===========================================================*
 * SECTION 6 : AGGREGATE FUNCTIONS
 *===========================================================*/

/* Why: To calculate the minimum, maximum, and average product/order price.
   Insight: Shows the overall pricing range and helps understand the general price level of products. */
SELECT
    MIN(unit_price_usd) AS minimum_price,
    MAX(unit_price_usd) AS maximum_price,
    AVG(unit_price_usd) AS average_price
FROM orders;

/* Why: To calculate the total amount paid across all revenue records.
   Insight: Provides the overall recorded revenue, which is a key business KPI. */
SELECT
    SUM(amount_paid_usd) AS total_revenue
FROM revenue;

/* Why: To calculate the average quantity purchased per order.
   Insight: Shows the typical order size and provides an indication of customer purchasing behavior. */
SELECT
    AVG(quantity) AS average_quantity
FROM orders;

/*===========================================================*
 * SECTION 7 : GROUP BY
 *===========================================================*/

/* Why: To count customers in each membership tier.
   Insight: Shows the composition of the customer base and identifies the most common membership segment. */
SELECT
    membership_tier,
    COUNT(*) AS customers
FROM customers
GROUP BY membership_tier;

/* Why: To count customers in each city and sort cities by customer volume.
   Insight: Identifies cities with the largest customer concentration and highlights important geographic markets. */
SELECT
    city,
    COUNT(*) AS customers
FROM customers
GROUP BY city
ORDER BY customers DESC;

/* Why: To count revenue transactions for each payment status.
   Insight: Helps evaluate payment performance and understand how transactions are distributed across statuses. */
SELECT
    payment_status,
    COUNT(*) AS total
FROM revenue
GROUP BY payment_status;

/* Why: To count orders for each payment method.
   Insight: Identifies the most popular payment methods and reveals customer payment behavior. */
SELECT
    payment_method,
    COUNT(*) AS total_orders
FROM orders
GROUP BY payment_method;


/*===========================================================*
 * SECTION 8 : INNER JOIN
 *===========================================================*/

/* Why: To combine customer information with order details using customer_id.
   Insight: Creates a customer-level order view showing who purchased what, how much they purchased, and at what price. */
SELECT
    o.order_id,
    c.customer_name,
    c.city,
    o.product_category,
    o.quantity,
    o.unit_price_usd
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id;

/* Why: To connect order information with its corresponding revenue/payment information using order_id.
   Insight: Shows what was ordered, how much was paid, and the payment status for that transaction. */
SELECT
    o.order_id,
    o.product_category,
    r.amount_paid_usd,
    r.payment_status
FROM orders o
INNER JOIN revenue r
ON o.order_id = r.order_id;


/*===========================================================*
 * SECTION 9 : THREE TABLE JOIN
 *===========================================================*/

/* Why: To combine customers, orders, and revenue into one transaction-level dataset.
   Insight: Provides a 360-degree transaction view connecting customer, location, product, quantity, price, payment amount, and payment status. */
SELECT
    o.order_id,
    c.customer_name,
    c.city,
    o.product_category,
    o.quantity,
    o.unit_price_usd,
    r.amount_paid_usd,
    r.payment_status
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN revenue r
ON o.order_id = r.order_id;


/*===========================================================*
 * SECTION 10 : BUSINESS QUESTIONS
 *===========================================================*/

/* Why: To identify the 10 customers who placed the highest number of orders.
   Insight: Shows the most active/repeat customers. This ranks customers by order frequency, not by revenue. */
-- Top 10 Customers by Number of Orders
SELECT
    c.customer_name,
    COUNT(*) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_orders DESC
LIMIT 10;

/* Why: To calculate total revenue generated from each city.
   Insight: Identifies the highest-revenue cities and highlights the strongest geographic markets. */
-- Revenue by City
SELECT
    c.city,
    SUM(r.amount_paid_usd) AS revenue
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN revenue r
ON o.order_id = r.order_id
GROUP BY c.city
ORDER BY revenue DESC;

/* Why: To calculate total revenue generated by each membership tier.
   Insight: Shows which customer segment contributes the most revenue and helps identify high-value membership groups. */
-- Revenue by Membership
SELECT
    c.membership_tier,
    SUM(r.amount_paid_usd) AS revenue
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN revenue r
ON o.order_id = r.order_id
GROUP BY c.membership_tier
ORDER BY revenue DESC;

/* Why: To identify product categories with the highest number of units sold.
   Insight: Shows which products have the strongest demand based on sales volume. */
-- Top Selling Products
SELECT
    product_category,
    SUM(quantity) AS quantity_sold
FROM orders
GROUP BY product_category
ORDER BY quantity_sold DESC
LIMIT 10;

/* Why: To identify product categories that generate the highest total revenue.
   Insight: Shows the products that contribute the most financially. The highest-selling product by quantity may not be the highest-revenue product because prices differ. */
-- Highest Revenue Products
SELECT
    o.product_category,
    SUM(r.amount_paid_usd) AS revenue
FROM orders o
JOIN revenue r
ON o.order_id = r.order_id
GROUP BY o.product_category
ORDER BY revenue DESC
LIMIT 10;

/*===========================================================*
 * SECTION 11 : HAVING
 *===========================================================*/

/* Why: To filter cities after grouping and keep only cities with more than 20 customers.
   Insight: Focuses the analysis on cities with a significant customer base and removes smaller markets. */
SELECT
    city,
    COUNT(*) AS customers
FROM customers
GROUP BY city
HAVING COUNT(*) > 20;

/* Why: To filter product categories after grouping and keep only categories with more than 100 units sold.
   Insight: Highlights products with relatively strong sales volume. */
SELECT
    product_category,
    SUM(quantity) AS quantity
FROM orders
GROUP BY product_category
HAVING SUM(quantity) > 100;


/*===========================================================*
 * SECTION 12 : CASE WHEN
 *===========================================================*/

/* Why: To convert membership tiers into broader business-friendly customer segments.
   Insight: Classifies customers as Premium, Regular, or Basic, which can support marketing and customer targeting. */
SELECT
    customer_name,
    membership_tier,
    CASE
        WHEN membership_tier = 'Gold' THEN 'Premium'
        WHEN membership_tier = 'Silver' THEN 'Regular'
        ELSE 'Basic'
    END AS customer_segment
FROM customers;

/* Why: To classify products into price segments based on their unit price.
   Insight: Helps understand the pricing structure by separating products into Expensive, Medium, and Budget categories. */
SELECT
    product_category,
    unit_price_usd,
    CASE
        WHEN unit_price_usd >= 1000 THEN 'Expensive'
        WHEN unit_price_usd >= 500 THEN 'Medium'
        ELSE 'Budget'
    END AS price_category
FROM orders;


/*===========================================================*
 * SECTION 13 : SUBQUERY
 *===========================================================*/

/* Why: To identify orders whose unit price is higher than the overall average price.
   Insight: Highlights above-average-priced products and potentially higher-value orders. */
SELECT *
FROM orders
WHERE unit_price_usd >
(
    SELECT AVG(unit_price_usd)
    FROM orders
);

/* Why: To identify transactions where the amount paid is higher than the overall average transaction value.
   Insight: Highlights high-value transactions and shows purchases that are larger than the typical transaction. */
SELECT *
FROM revenue
WHERE amount_paid_usd >
(
    SELECT AVG(amount_paid_usd)
    FROM revenue
);


/*===========================================================*
 * SECTION 14 : CTE
 *===========================================================*/

/* Why: To calculate total revenue for each customer using a Common Table Expression.
   Insight: Creates a customer-level revenue summary that helps identify the highest-value customers. */
WITH revenue_summary AS
(
    SELECT
        o.customer_id,
        SUM(r.amount_paid_usd) AS revenue
    FROM orders o
    JOIN revenue r
    ON o.order_id = r.order_id
    GROUP BY o.customer_id
)

SELECT *
FROM revenue_summary
ORDER BY revenue DESC;


/*===========================================================*
 * SECTION 15 : WINDOW FUNCTIONS
 *===========================================================*/

/* Why: To rank product categories based on total units sold.
   Insight: Shows the relative performance of each product category and identifies the best-performing categories by volume. */
SELECT
    product_category,
    SUM(quantity) AS quantity_sold,
    RANK() OVER (
        ORDER BY SUM(quantity) DESC
    ) AS product_rank
FROM orders
GROUP BY product_category;

/* Why: To rank customers according to the total revenue they generated.
   Insight: Identifies the highest-value customers based on revenue contribution. DENSE_RANK gives the same rank to tied revenue values without skipping the next rank. */
SELECT
    customer_id,
    SUM(amount_paid_usd) AS revenue,
    DENSE_RANK() OVER (
        ORDER BY SUM(amount_paid_usd) DESC
    ) AS revenue_rank
FROM orders o
JOIN revenue r
ON o.order_id = r.order_id
GROUP BY customer_id;


/*===========================================================*
 * SECTION 16 : ROW NUMBER
 *===========================================================*/

/* Why: To assign a sequential number to customers within each city.
   Insight: Allows customers to be ordered within each city and can support top-N, first/last customer, or deduplication analysis. */
SELECT
    customer_name,
    city,
    ROW_NUMBER() OVER (
        PARTITION BY city
        ORDER BY customer_name
    ) AS row_num
FROM customers;


/*===========================================================*
 * SECTION 17 : VIEW
 *===========================================================*/

/* Why: To create a reusable virtual table combining customer, order, and revenue information.
   Insight: Creates a simplified analysis layer that can be reused for reports, dashboards, and future SQL queries without rewriting the three-table JOIN. */
CREATE OR REPLACE VIEW customer_orders AS
SELECT
    c.customer_name,
    c.city,
    o.product_category,
    o.quantity,
    r.amount_paid_usd
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN revenue r
ON o.order_id = r.order_id;

/* Why: To retrieve the combined data stored in the customer_orders view.
   Insight: Provides an easy-to-use transaction-level dataset for further analysis and reporting. */
SELECT *
FROM customer_orders;


/*===========================================================*
 * SECTION 18 : FINAL KPIs
 *===========================================================*/

/* Why: To calculate the total number of customers.
   Insight: Measures the overall size of the customer base. */
SELECT COUNT(*) AS total_customers
FROM customers;

/* Why: To calculate the total number of orders.
   Insight: Measures overall order volume and customer activity. */
SELECT COUNT(*) AS total_orders
FROM orders;

/* Why: To calculate the total amount paid across all revenue transactions.
   Insight: Provides the overall recorded revenue generated in the dataset. */
SELECT SUM(amount_paid_usd) AS total_revenue
FROM revenue;

/* Why: To calculate the average amount paid per transaction.
   Insight: Shows the typical transaction value and helps understand average customer spending. */
SELECT AVG(amount_paid_usd) AS average_transaction
FROM revenue;

/* Why: To identify the largest transaction in the dataset.
   Insight: Shows the maximum customer payment and the highest-value individual purchase. */
SELECT MAX(amount_paid_usd) AS highest_transaction
FROM revenue;

/* Why: To identify the smallest transaction in the dataset.
   Insight: Shows the minimum recorded payment and the lower end of transaction values. */
SELECT MIN(amount_paid_usd) AS lowest_transaction
FROM revenue;




-- BHAIYA APKO YEH SAB INSIGHTS KA ANSWER DENA HA BACCHO KO LAST ME
/*===========================================================*
 * SECTION 19 : BUSINESS-ORIENTED INSIGHTS
 *===========================================================*/

/*
1. CUSTOMER AND MEMBERSHIP DISTRIBUTION

Business Insight:
The analysis shows how Amazon's customers are distributed across
different membership tiers. This helps identify the size and
composition of each customer segment and understand which membership
groups represent the largest portion of the customer base.

Business Action:
Membership-level customer distribution can be used to design
different retention, loyalty, and engagement strategies for each
customer segment.
*/


/*
2. GEOGRAPHIC CONCENTRATION

Business Insight:
The analysis compares customer concentration across cities and also
measures recorded revenue by city. This helps distinguish locations
with a large customer population from locations that generate stronger
revenue.

Business Action:
Cities with a large customer base can be targeted for retention and
customer engagement, while high-revenue cities can be prioritized
for revenue expansion and localized marketing strategies.
*/


/*
3. PAYMENT-METHOD BEHAVIOR

Business Insight:
The analysis identifies the most frequently used payment methods and
shows the distribution of transactions across different payment
statuses. This provides visibility into customer payment preferences
and transaction outcomes.

Business Action:
Amazon can optimize the most-used payment methods while monitoring
unsuccessful or problematic payment statuses to reduce payment
friction and improve the checkout experience.
*/


/*
4. PRODUCT-CATEGORY PERFORMANCE

Business Insight:
Product categories are evaluated using both quantity sold and
recorded revenue. This highlights that the category with the highest
sales volume may not necessarily be the category generating the
highest revenue.

Business Action:
High-volume products can be used to drive customer engagement and
order frequency, while high-revenue products should be prioritized
for revenue growth, upselling, and cross-selling opportunities.
*/


/*
5. CUSTOMER VALUE AND ACTIVITY

Business Insight:
The analysis distinguishes between highly active customers and
high-value customers. Order-count analysis identifies customers who
place orders frequently, while revenue summaries and DENSE_RANK()
identify customers contributing greater financial value.

Business Action:
Highly active customers can be targeted through loyalty and repeat-
purchase campaigns, while high-revenue customers should receive
stronger retention efforts and personalized offers.
*/


/*
6. PRICING AND TRANSACTION BEHAVIOR

Business Insight:
The analysis identifies orders priced above the overall average and
transactions with payment values above the average transaction value.
This highlights higher-priced purchases and higher-value transactions
within the dataset.

Business Action:
These higher-value transactions can be analyzed further to identify
premium purchasing patterns and opportunities for targeted upselling,
cross-selling, and personalized recommendations.
*/


/*
=============================================================
OVERALL BUSINESS CONCLUSION

The SQL analysis provides a multi-dimensional view of Amazon's
business performance across customers, membership segments,
geographic markets, payment behavior, product categories, and
transaction values.

The analysis can be used to identify high-value customers and
markets, understand product demand versus revenue contribution,
optimize payment experiences, and develop targeted strategies
for customer retention and revenue growth.
=============================================================
*/