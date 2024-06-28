-- Data Cleaning Script

-- 1. Create a staging table with the same structure as the existing table
SELECT *
INTO layoffs_staging
FROM layoffs
WHERE 1 = 0;

-- Insert data into the staging table
INSERT INTO layoffs_staging
SELECT * FROM layoffs;

-- 2. Remove Duplicates using CTE
WITH duplicate_cte AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY company, [location], industry, total_laid_off, percentage_laid_off, [date], stage, country, funds_raised_millions
               ORDER BY company
           ) AS row_num
    FROM layoffs_staging
)
DELETE FROM duplicate_cte
WHERE row_num > 1;

-- 3. Create a new table without duplicates
SELECT *
INTO layoffs_staging_no_dup
FROM layoffs_staging
WHERE 1 = 0;

INSERT INTO layoffs_staging_no_dup
SELECT * FROM layoffs_staging;

-- 4. Standardize Data
-- Trim company names
UPDATE layoffs_staging_no_dup
SET company = TRIM(company);

-- Unify industry names
UPDATE layoffs_staging_no_dup
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Unify country names
UPDATE layoffs_staging_no_dup
SET country = 'United States'
WHERE country LIKE 'United States%';

-- 5. Convert 'date' column to actual Date type
ALTER TABLE layoffs_staging_no_dup
ALTER COLUMN [date] DATE;

-- 6. Handle NULL and blank values
-- Replace 'NULL' text with actual NULL values
UPDATE layoffs_staging_no_dup
SET industry = NULL
WHERE industry = 'NULL';

-- Update industry based on other records
UPDATE t1
SET t1.industry = t2.industry
FROM layoffs_staging_no_dup t1
JOIN layoffs_staging_no_dup t2 ON t1.company = t2.company
WHERE t1.industry IS NULL
  AND t2.industry IS NOT NULL;

-- Delete rows with NULL in critical columns
DELETE FROM layoffs_staging_no_dup
WHERE total_laid_off = 'NULL'
  AND percentage_laid_off = 'NULL';

-- Final cleaned data
SELECT * FROM layoffs_staging_no_dup;
