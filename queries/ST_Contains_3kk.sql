-- MyISAM
CALL get_execution_time(10, 'select SQL_NO_CACHE ST_CONTAINS(p1.coords, p2.point) from article.points_myisam_3kk as p2 cross join article.polygons_myisam as p1 limit 4000000;');

-- InnoDB
CALL get_execution_time(10, 'select SQL_NO_CACHE ST_CONTAINS(p1.coords, p2.point) from article.points_innodb_3kk as p2 cross join article.polygons_innodb as p1 limit 4000000;');

-- Aria
CALL get_execution_time(10, 'select SQL_NO_CACHE ST_CONTAINS(p1.coords, p2.point) from article.points_aria_3kk as p2 cross join article.polygons_aria as p1 limit 4000000;');