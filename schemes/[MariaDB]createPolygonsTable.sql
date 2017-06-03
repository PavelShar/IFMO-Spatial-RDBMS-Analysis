use article;

-- Creating table with XtraDB Engine
DROP TABLE IF EXISTS `polygons_innodb`;
CREATE TABLE `polygons_innodb` (
  `coords` polygon NOT NULL,
  SPATIAL INDEX(`coords`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- Creating table with MyISAM Engine
DROP TABLE IF EXISTS `polygons_myisam`;
CREATE TABLE `polygons_myisam` (
  `coords` polygon NOT NULL,
  SPATIAL INDEX(`coords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- Creating table with Aria Engine
DROP TABLE IF EXISTS `polygons_aria`;
CREATE TABLE `polygons_aria` (
  `coords` polygon NOT NULL,
  SPATIAL INDEX(`coords`)
) ENGINE=Aria DEFAULT CHARSET=utf8;
