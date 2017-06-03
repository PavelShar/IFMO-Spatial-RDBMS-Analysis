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
