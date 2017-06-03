-- Aria
CALL get_execution_time(100, 'select SQL_NO_CACHE ST_Overlaps(c1.coords, c2.coords) from article.polygons_aria as c1 cross join article.polygons_aria as c2;');

-- MyISAM
CALL get_execution_time(100, 'select SQL_NO_CACHE ST_Overlaps(c1.coords, c2.coords) from article.polygons_myisam as c1 cross join article.polygons_myisam as c2;');

-- InnoDB
CALL get_execution_time(100, 'select SQL_NO_CACHE ST_Overlaps(c1.coords, c2.coords) from article.polygons_innodb as c1 cross join article.polygons_innodb as c2;');