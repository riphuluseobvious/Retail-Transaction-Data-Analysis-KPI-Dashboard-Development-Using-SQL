-- DATA CLEANNING

SELECT *
FROM retail_store_sales;

 --   1. Create a working copy of the dataset
 --   2. Identify and remove duplicates
 --   3. Standardize text fields
 --   4. Convert date formats
 --   5. Handle missing values

-- =====================================================
-- 1. CREATE A WORKING COPY OF THE DATA
-- =====================================================

CREATE TABLE retail_store_sales2
LIKE retail_store_sales;

INSERT retail_store_sales2
SELECT *
FROM retail_store_sales;

-- =====================================================
-- 2. IDENTIFY AND REMOVE DUPLICATES
-- =====================================================

SELECT *,
       ROW_NUMBER() OVER (
           PARTITION BY `Transaction ID`
           ORDER BY `Transaction ID`
       ) AS row_num
FROM retail_store_sales2;

-- If duplicates were present, we would remove them with:

DELETE FROM retail_store_sales2
WHERE `Transaction ID` IN (
    SELECT `Transaction ID`
    FROM (
        SELECT `Transaction ID`,
               ROW_NUMBER() OVER (
                   PARTITION BY `Transaction ID`
                   ORDER BY `Transaction ID`
               ) AS row_num
        FROM retail_store_sales2
    ) t
    WHERE row_num > 1
);


 -- =====================================================
-- 3. STANDARDIZE TEXT DATA
-- =====================================================

SELECT Category, TRIM(Category)
FROM retail_store_sales2;

UPDATE retail_store_sales2
SET Category=TRIM(Category);

-- =====================================================
-- 4. CONVERT DATE FORMAT
-- =====================================================

SELECT `Transaction Date`,
STR_TO_DATE (`Transaction Date`,'%m/%d/%Y')
FROM retail_store_sales2;

UPDATE retail_store_sales2
SET `Transaction Date`=STR_TO_DATE (`Transaction Date`,'%m/%d/%Y');

ALTER TABLE retail_store_sales2
MODIFY COLUMN `Transaction Date` DATE;

-- =====================================================
-- 5. HANDLE MISSING VALUES
-- =====================================================

SELECT `Discount Applied`,
COUNT(*) AS Total 
FROM retail_store_sales2
GROUP BY `Discount Applied`;

UPDATE retail_store_sales2
SET `Discount Applied` = 'FALSE'
WHERE `Discount Applied` = ''; 
 
 UPDATE retail_store_sales2
SET `Discount Applied` = UPPER(`Discount Applied`);


-- =====================================================
-- 6. FINAL DATA VALIDATION
-- =====================================================

-- Check distinct categories

SELECT DISTINCT Category
FROM retail_store_sales2;


-- Validate totals 

SELECT *
FROM retail_store_sales2
WHERE `Total Spent`= Quantity * `Price Per Unit`;


-- View cleaned dataset

SELECT *
FROM retail_store_sales2;


















