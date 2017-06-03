
/**
 * Returns the area of a closed path on a sphere of given radius.
 * The computed area uses the same units as the radius squared.
 * EARTH RADIUS = 6371009
 * PI = 3.141592653589
 */

DROP FUNCTION IF EXISTS GeometryArea;
DELIMITER $$
CREATE FUNCTION `GeometryArea`(`geometry` POLYGON) RETURNS DOUBLE DETERMINISTIC
BEGIN

    SET @EARTH_RADIUS := 6371009;
    SET @M_PI := 3.141592653589;

    SET @externalRing := ST_ExteriorRing(geometry);
    SET @pointsNum := NumPoints(@externalRing);

    IF @pointsNum IS NULL OR @pointsNum < 3 THEN
        RETURN 0;
    END IF;

    SET @total := 0;
    SET @prev := ST_PointN(@externalRing, @pointsNum);

    SET @prevTanLat := tan((pi()/2 - radians(ST_X(@prev))) /2);
    SET @prevLng := radians(ST_Y(@prev));

    set @pointN = 1;
    loop_points: LOOP


    IF @pointsNum < @pointN THEN
      LEAVE loop_points;
    END IF;

    SET @tanLat := tan((@M_PI/2 - radians(ST_X(ST_PointN(@externalRing, @pointN)))) / 2);
    SET @lng = radians(ST_Y(ST_PointN(@externalRing, @pointN)));

    set @total := @total + polarTriangleArea(@tanLat, @lng, @prevTanLat, @prevLng);
    set @prevTanLat := @tanLat;
    set @prevLng := @lng;

    SET @pointN = @pointN + 1;
    ITERATE loop_points;

  END LOOP;

  RETURN ABS(@total * (@EARTH_RADIUS * @EARTH_RADIUS));

END
$$
DELIMITER ;



/**
 * Returns the signed area of a triangle which has North Pole as a vertex.
 * Formula derived from "Area of a spherical triangle given two edges and the included angle"
 * as per "Spherical Trigonometry" by Todhunter, page 71, section 103, point 2.
 * See http://books.google.com/books?id=3uBHAAAAIAAJ&pg=PA71
 * The arguments named "tan" are tan((pi/2 - latitude)/2).
 */

DROP FUNCTION IF EXISTS polarTriangleArea;
DELIMITER $$
CREATE FUNCTION `polarTriangleArea` (`tan1` DOUBLE, `lng1` DOUBLE, `tan2` DOUBLE, `lng2` DOUBLE) RETURNS DOUBLE  DETERMINISTIC
BEGIN

    set @deltaLng := lng1 - lng2;
    set @t := tan1 * tan2;

    return 2 * atan2(@t * sin(@deltaLng), 1 + @t * cos(@deltaLng));

END
$$
DELIMITER ;


DROP FUNCTION IF EXISTS GetDistanceBetweenPoints;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetDistanceBetweenPoints`(`lat1` DOUBLE, `lon1` DOUBLE, `lat2` DOUBLE, `lon2` DOUBLE) RETURNS double
    DETERMINISTIC
RETURN ACOS( SIN(lat1*PI()/180)*SIN(lat2*PI()/180) + COS(lat1*PI()/180)*COS(lat2*PI()/180)*COS(lon2*PI()/180-lon1*PI()/180) ) * 6371009$$
DELIMITER ;