-- Aria
CALL get_execution_time(1000, 'select sql_no_cache asWKT(ST_centroid(coords)) from article.polygons_aria;');

-- MyISAM
CALL get_execution_time(1000, 'select sql_no_cache asWKT(ST_centroid(coords)) from article.polygons_myisam;');

-- InnoDB
CALL get_execution_time(1000, 'select sql_no_cache asWKT(ST_centroid(coords)) from article.polygons_innodb;');