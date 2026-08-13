-- VALIDITY: Check for incorrect data type for each column.

-- Change the incorrect data type into the correct one.
ALTER TABLE raw_inventory
MODIFY COLUMN Product_Name VARCHAR(50);

ALTER TABLE raw_inventory
MODIFY COLUMN Category VARCHAR(50);

ALTER TABLE raw_inventory
MODIFY COLUMN Warehouse VARCHAR(50);

ALTER TABLE raw_inventory
MODIFY COLUMN Location VARCHAR(50);

ALTER TABLE raw_inventory
MODIFY COLUMN Quantity INT;

ALTER TABLE raw_inventory
MODIFY COLUMN Price DECIMAL(10, 2);

ALTER TABLE raw_inventory
MODIFY COLUMN Supplier VARCHAR(50);

ALTER TABLE raw_inventory
MODIFY COLUMN Status VARCHAR(50);

ALTER TABLE raw_inventory
MODIFY COLUMN Last_Restocked DATE;

-- Change the date format so that the data type can be implemented.
UPDATE raw_inventory
SET Last_Restocked = STR_TO_DATE(Last_Restocked, '%d/%m/%Y');