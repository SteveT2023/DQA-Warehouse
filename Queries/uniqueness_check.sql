-- DUPLICATES: Check for values that appeared twice where it shouldn't be.

-- Check for duplicates in Product_ID.
SELECT
	Product_ID,
    COUNT(Product_ID) AS Duplicates
FROM raw_inventory
GROUP BY Product_ID
HAVING COUNT(Product_ID) >= 2;

-- Create a new column for the id to be unique.
ALTER TABLE raw_inventory
ADD COLUMN Unique_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;