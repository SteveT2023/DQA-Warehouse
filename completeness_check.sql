-- COMPLETENESS: Check for Nulls, Blanks, and Whitespaces for each column.

-- Create a procedure to count nulls, blanks, and whitespaces for each column and insert it into a temp table to display it.
DELIMITER //
	CREATE PROCEDURE completeness_check (IN col_name VARCHAR(50))
		BEGIN
			SET @query = CONCAT(
			'INSERT INTO display_completeness ',
			'SELECT ', 
				'"', col_name, '"', ' AS Columns, ',
				'SUM(CASE WHEN ', col_name, ' IS NULL THEN 1 ELSE 0 END) AS Null_Count, ',
				'SUM(CASE WHEN ', col_name, ' = "" THEN 1 ELSE 0 END) AS Blank_Count, ',
				'SUM(CASE WHEN ', col_name, ' = TRIM(', col_name, ') = "" AND ', col_name, ' != "" THEN 1 ELSE 0 END) AS Whitespace_Count ',
			'FROM raw_inventory'
            );
            
			PREPARE stmt FROM @query;
            EXECUTE stmt;
            DEALLOCATE PREPARE stmt;
		END //
DELIMITER ;

-- Create a temp table to display result.
CREATE TEMPORARY TABLE display_completeness
(
	Columns VARCHAR(50),
    Null_Count INT,
    Blank_Count INT,
    Whitespace_Count INT
);

-- Execute the procedure to find nulls, blanks, and whitespaces.
CALL completeness_check('Product_ID');
CALL completeness_check('Category');
CALL completeness_check('Warehouse');
CALL completeness_check('Location');
CALL completeness_check('Quantity');
CALL completeness_check('Price');
CALL completeness_check('Supplier');
CALL completeness_check('Status');
CALL completeness_check('Last_Restocked');

-- View results.
SELECT *
FROM display_completeness;