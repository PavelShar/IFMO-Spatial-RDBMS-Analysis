# Spatial RDBMS analysis: MySQL 5.7.17 vs MariaDB 10.3.0

### Installing MySQL (using Docker)  
1. Start mysql instance:  `docker run --name mysql -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=pass mysql:5.7.17`  
It start container `mysql` on 3306 port of your docker host and set root password = `pass`
  
2. You can use phpmyadmin as a convenient way of import/export data, schemes, procedures, etc. Also use docker to start myadmin instance: `docker run --name myadmin -d --link mysql:db -p 8080:80 phpmyadmin/phpmyadmin`.  
It uses 8080 port of docker host machine. Credentials: `root:pass`

3. `docker run -it --link mysql:mysql --rm mysql sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -ppass'` starts another mysql container instance and runs the mysql command line client against your original mysql container, allowing you to execute SQL statements. 

### Installing MariaDB (using Docker)  
The same idea with MariaDB.  
1. `docker run --name mariadb -e MYSQL_ROOT_PASSWORD=pass -d mariadb:10.3.0`
2. `docker run --name myadmin-mdb -d --link mariadb:db -p 8081:80 phpmyadmin/phpmyadmin` this time phpmyadmin started on 8081 port.  
3. `docker run -it --link mariadb:mysql --rm mariadb sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -ppass'`


### Schemes
Use schemes from folder `schemes` to create db structure.  
First execute `createDB.sql` or create db manually.  
Then execute `createResults.sql` to create "time-results-table".  
After execute all sql files with prefix **[MySQL]** for MySQL or with prefix **[MariaDB]** for MariaDB.  

### Functions and Procedures  
To install SQL procedures and functions just execute all `.sql` files from `procedures` folder. Maker shure that you are using right database before execution or just use `use %dbname%` (change %dbname% to your database) sql command before each execution.
* `GeometryArea` gets polygon field and return its area in square meters  
* `get_execution_time` gets number of iterations and query as string. This procedure returns void, but store execution time for each iteration in table `results`.
* `get_time_results` calculate min, max and average execution time for last query (from `get_execution_time`). This procedure rank results and remove 2,5% start and end tails to remove outliers. To see results you should use default pager or execute it from phpmyadmin.

### Data
All data from my analysis are in folder `data`. It contains polygons and points data for MyISAM engine. To compare different engine types you should clone data from this tables to similuar ones but with different engines.
> You can copy data with sql query like `insert into points_innodb_800k select * from points_myisam_800k`. Its very intensive operation. Some times you will need to rebuild table spatial index, so check its existens after copy.

### Queries
All queries for analysis are in folder `queries`.  
To get more accuracy results you should execute all queries in mysql/maria cli (not in phpmyadmin) to avoid data transfer from mysql/maria to phpmyadmin. Also you should suppress mysql/maria cli output and pass stderr stdout to /dev/null/. Just use `pager > /dev/null` in cli. To reset pager just execute `pager`.  
> Engine Aria supported only in MariaDB. So queries that use Aria won't work in MySQL

### My results
I test 108 polygons with 3 points pack: 800k, 3kk and 10kk.  
All execution time in seconds  

#### MySQL 5.7.17 (MyISAM)
| SQL                            	| Min      	| Max      	| Average  	| Iterations 	|
|--------------------------------	|----------	|----------	|----------	|------------	|
| ST_Centroid                    	| 0.003801 	| 0.029835 	| 0.010308 	| 1000       	|
| ST_NumPoints + ST_ExteriorRing 	| 0.001188 	| 0.024642 	| 0.007007 	| 1000       	|
| ST_ExteriorRing                	| 0.016257 	| 9.995251 	| 0.232375 	| 1000       	|
| ST_Overlaps                    	| 1.53927  	| 1.743081 	| 1.648591 	| 100        	|
| GeometryArea                   	| 0.447757 	| 0.601454 	| 0.479234 	| 100        	|

#### MariaDB 10.3.0 (XtraDB)
| SQL                            	| Min      	| Max      	| Average  	| Iterations 	|
|--------------------------------	|----------	|----------	|----------	|------------	|
| ST_Centroid                    	| 0.000831 	| 1.229162 	| 0.003299 	| 1000       	|
| ST_NumPoints + ST_ExteriorRing 	| 0.000490 	| 0.002692 	| 0.000987 	| 1000       	|
| ST_ExteriorRing                	| 0.012387 	| 1.924234 	| 0.254423 	| 1000       	|
| ST_Overlaps                    	| 0.945600 	| 1.989956 	| 1.394064 	| 100        	|
| GeometryArea                   	| 0.377513 	| 0.459000 	| 0.398138 	| 100        	|

#### MariaDB 10.3.0 (MyISAM)
| SQL                            	| Min      	| Max      	| Average  	| Iterations 	|
|--------------------------------	|----------	|----------	|----------	|------------	|
| ST_Centroid                    	| 0.000710 	| 0.265722 	| 0.001960 	| 1000       	|
| ST_NumPoints + ST_ExteriorRing 	| 0.000393 	| 0.010301 	| 0.000956 	| 1000       	|
| ST_ExteriorRing                	| 0.012026 	| 5.703852 	| 0.215109 	| 1000       	|
| ST_Overlaps                    	| 1.040729 	| 1.510067 	| 1.284243 	| 100        	|
| GeometryArea                   	| 0.372664 	| 0.441612 	| 0.390596 	| 100        	|

#### MariaDB 10.3.0 (Aria)
| SQL                            	| Min      	| Max      	| Average  	| Iterations 	|
|--------------------------------	|----------	|----------	|----------	|------------	|
| ST_Centroid                    	| 0.001149 	| 0.273795 	| 0.003273 	| 1000       	|
| ST_NumPoints + ST_ExteriorRing 	| 0.000906 	| 0.013140 	| 0.002208 	| 1000       	|
| ST_ExteriorRing                	| 0.012414 	| 1.485129 	| 0.228626 	| 1000       	|
| ST_Overlaps                    	| 1.163341 	| 1.411400 	| 1.299009 	| 100        	|
| GeometryArea                   	| 0.373162 	| 0.516149 	| 0.393356 	| 100        	|



