-- Aria
CALL get_execution_time(100, 'select sql_no_cache GeometryArea(coords) as area from article.polygons_aria;');

-- MyISAM
CALL get_execution_time(100, 'select sql_no_cache GeometryArea(coords) as area from article.polygons_myisam;');

-- InnoDB/XtraDB
CALL get_execution_time(100, 'select sql_no_cache GeometryArea(coords) as area from article.polygons_innodb;');