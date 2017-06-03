DROP PROCEDURE IF EXISTS `get_time_results`;
DELIMITER $$
CREATE PROCEDURE get_time_results()

BEGIN

select count(*) from results into @loops;
select  ROUND(MIN(t.res),9) as `min`, ROUND(MAX(t.res),9) as `max`, ROUND(AVG(t.res),9) as `average`
	from (
		SELECT t2.res, @curRow := @curRow + 1 AS row_number
		FROM (SELECT * FROM results order by res asc) as t2
		JOIN (SELECT @curRow := 0) r
		HAVING row_number >= @loops*0.025 and row_number <= @loops*0.975
		order by row_number
	) as t;

END $$
DELIMITER ;