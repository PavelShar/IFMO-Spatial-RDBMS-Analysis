DROP PROCEDURE IF EXISTS `get_execution_time`;
DELIMITER $$
CREATE PROCEDURE get_execution_time(IN loops INT(10), in q TEXT)

BEGIN
DECLARE start_time bigint;
DECLARE end_time bigint;

SET @SQL = q;
SET @LOOPS = loops;
	TRUNCATE results;
		
	 WHILE @LOOPS > 0  DO

		-- Fix start time in microseconds
		SET @start_time = (UNIX_TIMESTAMP(NOW()) * 1000000 + MICROSECOND(NOW(6)));

		-- Execute SQL
		FLUSH TABLES;
		PREPARE stmt FROM @SQL;
		EXECUTE stmt;

		-- Fix end time in microseconds
		SET @end_time = (UNIX_TIMESTAMP(NOW()) * 1000000 + MICROSECOND(NOW(6)));
		SET @RES := (@end_time - @start_time) / 1000000;
		INSERT INTO results (`res`, `loop`) VALUES (@RES, @LOOPS);
		
		SET @LOOPS := @LOOPS - 1;
	END WHILE;	
END $$
DELIMITER ;