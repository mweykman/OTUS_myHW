#! /bin/bash
yum install https://repo.percona.com/yum/percona-release-latest.noarch.rpm -y
yum install Percona-Server-server-57 -y
cp /vagrant/conf/conf.d/* /etc/my.cnf.d/
systemctl start mysql
cat /var/log/mysqld.log | grep 'root@localhost:' | awk '{print $11}'
mysql -uroot -p'*mulP>&68v/A'
mysql > ALTER USER USER() IDENTIFIED BY 'YourStrongPassword';
mysql> SELECT @@server_id;
mysql> SHOW VARIABLES LIKE 'gtid_mode';
mysql> CREATE DATABASE bet;
mysql> exit
mysql -uroot -p -D bet < /vagrant/bet.dmp
mysql -uroot -p
mysql> CREATE USER 'repl'@'%' IDENTIFIED BY '!RepPass123';
mysql> SELECT user,host FROM mysql.user where user='repl';
mysql> GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%' IDENTIFIED BY '!RepPass123';
mysql> exit
cd /vagrant
mysql -uroot -p
mysqldump --all-databases --triggers --routines --master-data --ignore-table=bet.events_on_demand --ignore-table=bet.v_same_event -uroot -p > master.sql



CHANGE MASTER TO MASTER_HOST = "192.168.56.150", MASTER_PORT = 3306, MASTER_USER = "repl", MASTER_PASSWORD = "!RepPass123", MASTER_AUTO_POSITION = 1;

mysql> USE bet;
mysql> INSERT INTO bookmaker (id,bookmaker_name) VALUES(1,'1xbet');
mysql> SELECT * FROM bookmaker;