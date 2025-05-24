![CoverImg](https://github.com/user-attachments/assets/a376ebcd-e26e-44a6-a7fe-76533b7d0070)
# 🎬 Netflix Titles SQL Project
This project is a comprehensive SQL-based analysis of the **Netflix Titles Dataset**, which contains metadata on all movies and TV shows available on Netflix up to mid-2021. The goal is to demonstrate SQL querying skills, data exploration techniques, and data-driven insights using a real-world dataset.

## 🛠 Data Import Process (CSV)
The Netflix Titles dataset was successfully imported into **MySQL** using the built-in CSV import functionality in **MySQL Workbench**. The import process auto-generated the schema based on the CSV structure and resolved previous encoding issues by setting the proper character set.

### ✅ Steps Followed:
1. Open **MySQL Workbench** and Create database using command: <pre> ```CREATE DATABASE Netflix; ``` </pre>
2. Use the database with the command: <pre> ```USE Netflix; ``` </pre>
3. Right-click on **Database Created** → Select **Table Data Import Wizard**.
![Screenshot 2025-05-24 at 15 50 32](https://github.com/user-attachments/assets/9b07f3b9-a168-4667-be36-175cb12df5de)
4. Choose the CSV file: `netflix_titles.csv`.
5. In the wizard, review and confirm column mappings.
6. Make sure to set encoding to `UTF-8` (important for special characters).
![Screenshot 2025-05-24 at 17 52 43](https://github.com/user-attachments/assets/c9d95801-e475-404d-812f-76cd38a34029)
7. Click **Next** to complete the import.

### 📌 Notes:
- If you encounter issues with `date_added`, ensure the date format in CSV is consistent.
- Recommended table name: `netflixdata`.
- Make sure to clean headers if there are extra spaces or hidden characters.
   
## 🧠 Project Objectives
- Practice and showcase SQL skills.
- Extract meaningful insights from Netflix's content catalog.
- Build a reusable library of SQL queries for similar datasets.
---

## 🛠 Technologies Used

- **Database**: MySQL
- **Data Format**: CSV (for smooth import into MySQL)
- **Tools**: SQL Workbench

---
## SQL Queries with Objectives, Findings, and Conclusions
---
### 1. Count total records
<pre>SELECT COUNT(*) AS total_titles FROM netflixdata;</pre>
**Objective**:
Find the total number of titles (movies + TV shows) available in the dataset.
**Findings**:
There are X titles in total.
**Conclusion**:
This gives an overview of dataset size, useful for understanding Netflix’s content library scale.
