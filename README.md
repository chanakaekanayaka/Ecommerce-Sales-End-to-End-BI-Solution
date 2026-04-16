# 🚀 E-commerce Sales: End-to-End BI Solution

## 📌 Project Overview
This repository showcases a complete Business Intelligence lifecycle, transforming raw transactional data into high-level business insights. This project is specifically designed for an E-commerce retail environment using a modern Data Warehousing approach.

---

## 🏗️ Phase 1: Data Warehouse Engineering & ETL (Assignment 01)
This phase focuses on backend architecture, dimensional modeling, and the automation of data movement using **SQL Server** and **SSIS**.

### **1. Data Modeling (Star Schema)**
I designed a high-performance **Star Schema** to optimize analytical query execution. The architecture consists of a central **FactOrders** table and 4 Dimension tables.

* **Fact Table:** `FactOrders` (Measures: Quantity, Price, Fulfillment time)
* **Dimensions:** `DimUser`, `DimProduct`, `DimOrderStatus`, `DimDate`

![Star Schema](Data-Engineering-ETL-project/Database-Design/star_schema.png.png)

---

### **2. ETL Pipeline & Automation (SSIS)**
Leveraging **SQL Server Integration Services (SSIS)**, I developed a robust ETL pipeline to handle data extraction from CSV/Excel, staging, and final loading.

**Technical Implementations:**
* **Slowly Changing Dimensions (SCD Type 2):** Implemented on `DimProduct` to track historical price fluctuations.
* **Accumulating Fact Logic:** Configured to measure total processing time from order creation to fulfillment.

![SSIS Workflow](Data-Engineering-ETL-project/Database-Design/ssis_workflow.png.png)

---

### **3. Integrity & Verification**
The logic was verified through data profiling and SQL testing to ensure that historical tracking and fact calculations are 100% accurate.

![SCD Logic](Data-Engineering-ETL-project/Database-Design/scd_logic.png.png)

---

## 🛠️ Technology Stack
* **Database:** Microsoft SQL Server (T-SQL)
* **ETL Engine:** SQL Server Integration Services (SSIS)
* **Modeling:** Dimensional Modeling (Star Schema)
* **Documentation:** [Technical Report (PDF)](Data-Engineering-ETL-project/Database-Design/IT23809024.pdf)

---

## 📂 Repository Structure (Assignment 01)
* **`/01-Data-Warehouse-Engineering/SQL-Scripts`**: T-SQL scripts for Staging and DW creation.
* **`/01-Data-Warehouse-Engineering/SSIS-Packages`**: ETL automation logic files (.dtsx).
* **`/01-Data-Warehouse-Engineering/Database-Design`**: Diagrams, screenshots, and the **Technical Report**.
