-- ACCURACY: Finding values that is incorrect base on other values in the table.			

-- Find incorrect values.
SELECT Quantity, Status
FROM raw_inventory
WHERE Status = 'Out of Stock';

-- Update the status based on the quantity.
UPDATE raw_inventory
SET Status = 'Out of Stock'
WHERE Quantity IS NULL OR Quantity <= 0;

UPDATE raw_inventory
SET Status = 'Low Stock'
WHERE Quantity < 100;

UPDATE raw_inventory
SET Status = 'In Stock'
WHERE Quantity >= 100;

-- While trying to filter Product_Name, I've discovered that there is hidden spaces in them. Removing spaces.
UPDATE raw_inventory
SET Product_Name = TRIM(Product_Name);