use article;

DROP TABLE IF EXISTS `polygons_innodb`;
CREATE TABLE `polygons_innodb` (
  `id` int(255) NOT NULL,
  `coords` polygon NOT NULL,
  SPATIAL INDEX(`coords`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `polygons_myisam`;
CREATE TABLE `polygons_myisam` (
  `id` int(255) NOT NULL,
  `coords` polygon NOT NULL,
  SPATIAL INDEX(`coords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;