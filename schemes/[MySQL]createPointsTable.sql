use article;

-- Creating table for 800k points
DROP TABLE IF EXISTS `points_innodb_800k`;
CREATE TABLE `points_innodb_800k` (
  `point` point NOT NULL,
  SPATIAL INDEX(`point`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `points_myisam_800k`;
CREATE TABLE `points_myisam_800k` (
  `point` point NOT NULL,
  SPATIAL INDEX(`point`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Creating table for 3kk points
DROP TABLE IF EXISTS `points_innodb_3kk`;
CREATE TABLE `points_innodb_3kk` (
  `point` point NOT NULL,
  SPATIAL INDEX(`point`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `points_myisam_3kk`;
CREATE TABLE `points_myisam_3kk` (
  `point` point NOT NULL,
  SPATIAL INDEX(`point`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- Creating table for 10kk points
DROP TABLE IF EXISTS `points_innodb_10kk`;
CREATE TABLE `points_innodb_10kk` (
  `point` point NOT NULL,
  SPATIAL INDEX(`point`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `points_myisam_10kk`;
CREATE TABLE `points_myisam_10kk` (
  `point` point NOT NULL,
  SPATIAL INDEX(`point`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;