#!/bin/bash 
set -e 
SQL_PASSWORD=$(cat /run/secrets/sql_password) 
if [ ! -d "/var/lib/mysql/mysql" ]; then 

    mysql_install_db --user=mysql --datadir=/var/lib/mysql 
fi 
mysqld_safe --datadir=/var/lib/mysql & 
pid=$!

until mysqladmin ping --silent; do
    echo "Waiting MariaDB..." 
    sleep 2 
done 

sleep 5 

mysql -u root <<EOF 
CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE}; 
CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}'; 
GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'%'; 
FLUSH PRIVILEGES; 
EOF

wait $pid
