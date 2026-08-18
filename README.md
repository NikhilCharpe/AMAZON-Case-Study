# 🛒 Amazon E-Commerce Data Analytics Case Study

> **End-to-End Data Analytics Project | Python • Pandas • PostgreSQL • SQL • Power BI**

An end-to-end **Data Analytics case study** built around Amazon-style e-commerce data to analyze customer behavior, order performance, payment activity, revenue patterns, product categories, and membership segments.

The project follows a complete analytics workflow — from **raw data exploration and cleaning to SQL-based business analysis and interactive Power BI visualization**.

---

## 📌 Project Overview

E-commerce businesses generate large volumes of customer, order, and transaction data. However, raw data alone does not provide actionable business insights.

This project focuses on transforming raw Amazon e-commerce datasets into meaningful insights by answering questions such as:

* Which product categories generate the highest revenue?
* Which customer segments contribute the most revenue?
* Which cities have the highest customer concentration?
* What are the most frequently purchased product categories?
* Which payment methods are most commonly used?
* How do Prime and Non-Prime customers differ?
* What are the key revenue and transaction KPIs?
* Which customers and categories deserve greater business attention?

The project combines **Python-based EDA, PostgreSQL analysis, advanced SQL, and Power BI dashboards** to create a complete analytical solution.

---

# 🎯 Business Objectives

The primary objectives of this case study are:

1. Understand the structure and quality of the available datasets.
2. Identify missing values, duplicates, and potential data-quality issues.
3. Explore customer demographics and membership distribution.
4. Analyze order volume, product categories, pricing, and order status.
5. Analyze payment and revenue performance.
6. Identify high-performing categories and customer segments.
7. Use SQL to answer real-world business questions.
8. Build an interactive Power BI dashboard for decision-making.
9. Convert raw transactional data into actionable business insights.

---

# 🗂️ Project Structure

```text
amazon-case-study/
│
├── 📊 amazon_customers.csv
├── 🛍️ amazon_orders.csv
├── 💰 amazon_revenue.csv
│
├── 🐍 Amazon_EDA_Phase_1.ipynb
│
├── 🐘 amazon_postgrace_phase2.sql
│
├── 📈 amazon_case_study_dashboard.pbix
│
├── 📄 Amazon_Data_Analyst_Case_Study.pdf
│
└── README.md
```

---

# 📊 Dataset Overview

The project contains three primary datasets.

## 1. Customers Dataset

**File:** `amazon_customers.csv`

Contains customer-level information including:

| Column            | Description                |
| ----------------- | -------------------------- |
| `customer_id`     | Unique customer identifier |
| `customer_name`   | Customer name              |
| `email`           | Customer email             |
| `city`            | Customer city              |
| `state_or_region` | State/region               |
| `country`         | Customer country           |
| `signup_date`     | Customer registration date |
| `membership_tier` | Membership category        |

**Records:** 10,166

---

## 2. Orders Dataset

**File:** `amazon_orders.csv`

Contains order-level transactional information.

| Column             | Description             |
| ------------------ | ----------------------- |
| `order_id`         | Unique order identifier |
| `customer_id`      | Customer identifier     |
| `order_date`       | Date of order           |
| `product_category` | Product category        |
| `quantity`         | Number of items ordered |
| `unit_price_usd`   | Unit price in USD       |
| `order_status`     | Order status            |
| `payment_method`   | Payment method used     |

**Records:** 10,166

---

## 3. Revenue Dataset

**File:** `amazon_revenue.csv`

Contains payment and revenue information.

| Column              | Description               |
| ------------------- | ------------------------- |
| `revenue_id`        | Unique revenue identifier |
| `order_id`          | Associated order          |
| `payment_date`      | Payment date              |
| `amount_paid_usd`   | Amount paid               |
| `payment_status`    | Payment status            |
| `refund_amount_usd` | Refund amount             |

**Records:** 9,664

---

# 🔍 Phase 1 — Exploratory Data Analysis

EDA was performed using **Python, Pandas, NumPy, Matplotlib, and Seaborn**.

### Key areas covered:

* Dataset structure and dimensions
* Data types
* Statistical summaries
* Missing-value analysis
* Duplicate-record detection
* Unique-value analysis
* Value-frequency analysis
* Data-quality assessment
* Customer email inspection
* Order-data cleaning
* Revenue-data cleaning

### EDA Workflow

```text
Raw Data
   ↓
Data Inspection
   ↓
Data Type Validation
   ↓
Missing Value Analysis
   ↓
Duplicate Detection
   ↓
Unique & Frequency Analysis
   ↓
Data Cleaning
   ↓
Statistical Analysis
   ↓
Business Insights
```

The complete analysis is available in:

`Amazon_EDA_Phase_1.ipynb`

---

# 🧹 Data Quality & Cleaning

Before performing business analysis, the datasets were inspected for common data-quality problems.

The analysis includes:

* Missing-value detection
* Duplicate-record checks
* Data-type validation
* Null-value inspection
* Categorical-value inspection
* Email-column inspection
* Order-data validation
* Revenue-data validation

This ensures that downstream SQL analysis and dashboard metrics are based on a cleaner analytical dataset.

---

# 🐘 Phase 2 — PostgreSQL & SQL Analysis

The cleaned datasets were analyzed using **PostgreSQL**.

The SQL analysis covers both fundamental and advanced SQL concepts.

### SQL Concepts Used

* `SELECT`
* `WHERE`
* `DISTINCT`
* `COUNT`
* `SUM`
* `AVG`
* `MIN`
* `MAX`
* `GROUP BY`
* `HAVING`
* `INNER JOIN`
* Multi-table joins
* `CASE WHEN`
* Subqueries
* CTEs
* Window Functions
* `RANK()`
* `DENSE_RANK()`
* `ROW_NUMBER()`
* `PARTITION BY`
* Views

---

# 💡 Business Questions Answered

The SQL analysis was designed around practical business questions rather than only technical queries.

### Customer Analysis

* How many customers are present?
* How are customers distributed across membership tiers?
* Which cities have the highest number of customers?
* Who are the top customers by order volume?

### Order Analysis

* What is the average quantity per order?
* What are the minimum, maximum, and average product prices?
* Which product categories sell the highest quantity?
* What is the distribution of order statuses?
* Which payment methods are most frequently used?

### Revenue Analysis

* What is the total revenue?
* What is the average transaction value?
* Which cities generate the highest revenue?
* Which membership tiers generate the most revenue?
* Which product categories generate the highest revenue?
* What are the highest and lowest transaction values?

### Advanced Analysis

The project also demonstrates:

* Customer revenue ranking
* Product-category ranking
* Customer segmentation using `CASE WHEN`
* Above-average transaction identification
* CTE-based customer revenue analysis
* City-level row numbering
* Reusable SQL views

---

# 📈 Power BI Dashboard

The final analytical layer is an interactive **Power BI dashboard**.

The dashboard transforms the SQL and EDA findings into a business-friendly visual interface.

### Dashboard Focus Areas

* Revenue performance
* Customer metrics
* Order metrics
* Product-category performance
* Membership analysis
* Payment analysis
* Geographic/customer distribution
* Key business KPIs

The Power BI file is included in the repository as:

`amazon_case_study_dashboard.pbix`

---

# 🧠 Key Analytical Dimensions

The project analyzes performance across multiple business dimensions:

### 👥 Customer

* Customer
* City
* State/Region
* Country
* Membership Tier

### 🛍️ Product

* Product Category
* Quantity
* Unit Price

### 💳 Transaction

* Payment Method
* Payment Status
* Amount Paid
* Refund Amount

### 📦 Order

* Order Status
* Order Date
* Order Volume

### 💰 Revenue

* Total Revenue
* Average Transaction Value
* Revenue by Category
* Revenue by Membership
* Revenue by City

---

# 🛠️ Technology Stack

| Technology           | Purpose                           |
| -------------------- | --------------------------------- |
| **Python**           | Data analysis & preprocessing     |
| **Pandas**           | Data manipulation                 |
| **NumPy**            | Numerical analysis                |
| **Matplotlib**       | Data visualization                |
| **Seaborn**          | Statistical visualization         |
| **PostgreSQL**       | Relational database analysis      |
| **SQL**              | Business analysis & querying      |
| **Power BI**         | Interactive dashboard             |
| **Jupyter Notebook** | EDA & documentation               |
| **Git & GitHub**     | Version control & project sharing |

---

# 🔄 End-to-End Analytics Workflow

```text
                 RAW DATA
                    │
                    ▼
        ┌─────────────────────┐
        │   Data Exploration  │
        │      Python/EDA     │
        └──────────┬──────────┘
                   │
                   ▼
        ┌─────────────────────┐
        │   Data Cleaning     │
        │ Pandas / Validation │
        └──────────┬──────────┘
                   │
                   ▼
        ┌─────────────────────┐
        │     PostgreSQL      │
        │    SQL Analysis     │
        └──────────┬──────────┘
                   │
                   ▼
        ┌─────────────────────┐
        │ Business Questions  │
        │   & KPI Analysis    │
        └──────────┬──────────┘
                   │
                   ▼
        ┌─────────────────────┐
        │      Power BI       │
        │ Interactive Report  │
        └──────────┬──────────┘
                   │
                   ▼
             BUSINESS
             INSIGHTS
```

---

# 📌 Project Deliverables

This repository contains:

### 1. Python EDA

`Amazon_EDA_Phase_1.ipynb`

Complete exploratory analysis and data-quality investigation.

### 2. PostgreSQL Analysis

`amazon_postgrace_phase2.sql`

SQL queries covering basic, intermediate, and advanced analytical concepts.

### 3. Power BI Dashboard

`amazon_case_study_dashboard.pbix`

Interactive dashboard for business-level reporting.

### 4. Raw Datasets

* `amazon_customers.csv`
* `amazon_orders.csv`
* `amazon_revenue.csv`

### 5. Case Study Document

`Amazon_Data_Analyst_Case_Study.pdf`

Contains the original case-study requirements and business context.

---

# 🚀 How to Run the Project

## Step 1 — Clone the Repository

```bash
git clone https://github.com/<your-username>/amazon-case-study.git

cd amazon-case-study
```

---

## Step 2 — Install Python Dependencies

```bash
pip install pandas numpy matplotlib seaborn jupyter
```

---

## Step 3 — Run the EDA Notebook

Start Jupyter:

```bash
jupyter notebook
```

Open:

```text
Amazon_EDA_Phase_1.ipynb
```

Make sure the CSV files are located in the same directory as the notebook.

---

## Step 4 — PostgreSQL Setup

Create a PostgreSQL database, for example:

```sql
CREATE DATABASE amazon_db;
```

Create/import the following tables:

```text
customers
orders
revenue
```

Then execute:

```text
amazon_postgrace_phase2.sql
```

---

## Step 5 — Open the Power BI Dashboard

Open:

```text
amazon_case_study_dashboard.pbix
```

in **Microsoft Power BI Desktop**.

If required, update the data-source paths/connections according to your local environment.

---

# 📊 Analytical Architecture

```text
Customers ─────┐
               │
               ├──── Customer & Order Analysis
               │
Orders ────────┤
               │
               ├──── Revenue Analysis
               │
Revenue ───────┘
               │
               ▼
          PostgreSQL
               │
               ▼
        Business Metrics
               │
               ▼
            Power BI
               │
               ▼
       Decision Insights
```

---

# 🎓 What This Project Demonstrates

This project demonstrates practical proficiency in:

* Exploratory Data Analysis
* Data Cleaning
* Data Quality Assessment
* Relational Data Analysis
* SQL Joins
* Aggregation & Grouping
* Business KPI Development
* Customer Segmentation
* Revenue Analysis
* Advanced SQL
* Window Functions
* CTEs
* Subqueries
* PostgreSQL
* Power BI Dashboard Development
* Data Storytelling
* Business-oriented analytical thinking

---

# 💼 Business Value

The primary goal of this project is not simply to write Python or SQL queries.

The goal is to demonstrate the complete process of converting:

**Raw Data → Clean Data → Analysis → KPIs → Visualization → Business Insights**

This approach mirrors a real-world **Data Analyst workflow**, where technical analysis must ultimately support better business decisions.

---

# 🔮 Future Improvements

The project can be further extended with:

* Customer Lifetime Value (CLV)
* RFM Customer Segmentation
* Customer Churn Analysis
* Cohort Analysis
* Monthly Revenue Trends
* Repeat Purchase Rate
* Refund Rate Analysis
* Customer Retention Analysis
* Product Profitability Analysis
* Advanced Power BI DAX measures
* Automated ETL pipelines
* Scheduled dashboard refresh
* Predictive sales forecasting
* Customer purchase prediction

---

# 👨‍💻 Author

**Nikhil Charpe**

Data Analyst | Python | SQL | Power BI | Data Analytics

Focused on transforming data into actionable business insights through **analytics, visualization, and problem-solving**.

---

# ⭐ If You Found This Project Useful

If this project helped you understand an end-to-end data analytics workflow, consider giving the repository a ⭐.

Feedback, suggestions, and improvements are always welcome.

---

## 📜 License

This project is created for **educational, portfolio, and analytical demonstration purposes**.
