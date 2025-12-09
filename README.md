# 📦 Olist E-commerce Data Analysis Project

This project analyzes the **Brazilian Olist E-commerce dataset** using **Python, PostgreSQL, and Power BI** to generate business insights, KPIs, and dashboards.
It demonstrates end-to-end data analytics workflow — from cleaning and SQL transformations to reporting.

---

## 📁 Project Structure

```
├── clean_data.ipynb
├── tables_creation.sql
├── cleaning_transformations.sql
├── analysis_queries.sql
├── advanced_queries.sql
├── final_kpi_queries.sql
├── powerbi_dashboard.pbix
└── README.md
```



## 📊 Dataset Summary

The dataset contains **7 tables**:

* **customers** – customer location & unique IDs
* **sellers** – seller location
* **products** – product category & weight
* **orders** – order status & timestamps
* **order_items** – price, freight, seller details
* **payments** – payment types and values
* **order_reviews** – customer ratings



## 🔧 Tools Used

* **Python (Pandas, NumPy)** – data cleaning
* **PostgreSQL** – SQL transformations & analysis
* **Power BI** – dashboard and insights
* **Jupyter Notebook** – EDA
* **GitHub** – version control



## 🧹 Data Cleaning (Python)

Performed in `clean_data.ipynb`:

* Removed duplicates
* Handled missing dates
* Standardized column names
* Joined product categories
* Exported cleaned CSV files for SQL



## 🗄️ SQL Work

All SQL scripts are included:

* **01_tables.sql** → schema & table creation
* **02_cleaning_transformations.sql** → data cleaning, new columns (installments flag, revenue)
* **03_analysis_queries.sql** → order trends, revenue, payments, reviews
* **04_advanced_queries.sql** → RFM, window functions, ranking
* **05_final_kpi_queries.sql** → business KPIs



## 📈 Key Insights (Power BI)

Dashboard includes:

* Total Revenue, Total Orders, AOV
* Monthly Sales Trend
* Top Product Categories
* Delivery Performance
* Payment Type Distribution
* Customer Ratings Overview
* Seller Performance


