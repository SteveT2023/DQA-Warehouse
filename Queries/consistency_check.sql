-- CONSISTENCY: Find columns where the values are not consistent.

-- Create a procedure to distinct values in a columns to look for invalid data.
DELIMITER //
	CREATE PROCEDURE consistency_check (IN col_name VARCHAR(50))
		BEGIN
			SET @query = CONCAT(
				'SELECT DISTINCT ', col_name, ' ',
                'FROM raw_inventory'
            );
            
            PREPARE stmt FROM @query;
            EXECUTE stmt;
            DEALLOCATE PREPARE stmt;
        END //
DELIMITER ;

-- Find columns that are not consistent.
SELECT Product_ID
FROM raw_inventory
WHERE Product_ID REGEXP '[a-zA-z]';

CALL consistency_check('Product_Name');
CALL consistency_check('Category');
CALL consistency_check('Warehouse');
CALL consistency_check('Location');
CALL consistency_check('Quantity'); -- Invalid data: two hundred & NaN
CALL consistency_check('Price'); -- Invalid data: NaN
CALL consistency_check('Supplier');
CALL consistency_check('Status');
CALL consistency_check('Last_Restocked'); -- Invalid data: NaN

-- Remove the invalid data for each columns.
UPDATE raw_inventory
SET Quantity = 200
WHERE Quantity = 'two hundred';

UPDATE raw_inventory
SET Quantity = NULL
WHERE Quantity = 'NaN';

UPDATE raw_inventory
SET Price = NULL
WHERE Price = 'NaN';

UPDATE raw_inventory
SET Last_Restocked = NULL
WHERE Last_Restocked = 'NaN';