# MySQL Data Cleaning Project

This project demonstrates a data cleaning process using MySQL on a dataset of company layoffs. The project involves several key steps to ensure the data is clean and ready for analysis.

## Project Description

The goal of this project is to clean a sample dataset of layoffs by performing the following steps:

1. **Removing Duplicates:** Using Common Table Expressions (CTEs) to identify and remove duplicate records.
2. **Standardizing Data:** Ensuring consistency in company names, industry names, and country names.
3. **Handling NULL and Blank Values:** Cleaning up NULL and blank values in critical columns.
4. **Removing Unnecessary Columns:** Streamlining the dataset by removing columns that are not needed.

## Files

- `data_cleaning.sql`: The SQL script that performs the data cleaning.
- `layoffs.csv`: A sample data file used for testing the script.

## Instructions

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/your-username/mysql-data-cleaning-project.git
   cd mysql-data-cleaning-project

2. **Load the Sample Data:**

- Open MySQL Workbench or your preferred MySQL client.
- Create the layoffs table to match the structure of layoffs.csv:
SQL :

CREATE TABLE layoffs (
    company VARCHAR(255),
    location VARCHAR(255),
    industry VARCHAR(255),
    total_laid_off INT,
    percentage_laid_off FLOAT,
    date VARCHAR(255),
    stage VARCHAR(255),
    country VARCHAR(255),
    funds_raised_millions FLOAT
);

- Load the CSV data into the layoffs table:
SQL :

LOAD DATA INFILE '/path/to/layoffs.csv'
INTO TABLE layoffs
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

3. **Run the Data Cleaning Script:**

- Execute the data_cleaning.sql script in your MySQL client to clean the data.

4. **Verify the Results:**

- Query the layoffs_staging_no_dup table to see the cleaned data:
SQL :
SELECT * FROM layoffs_staging_no_dup;



