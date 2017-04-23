#!/bin/bash


1.[MysqlDump]
==export==
mysqldump -uusername -ppassword  --all-databases > all.sql      ;;all database   
mysqldump -uusername -ppassword --databases db1 db2 > db1db2.sql  ;;databases
mysqldump -uusername -ppassword db1 table1 table2 > tb1tb2.sql  ;;table of database

==import==
>source all.sql           ;;all databases
>source db1db2.sql        ;;databases
mysql -uusername -ppassword db1 < db1.sql;      ;;database
mysql -uusername -ppassword db1 < tb1tb2.sql      ;;table of database
	>user db1;
	>source tb1tb2.sql;


2.[Grant]	
grant/revoke need reconnect server,for it works.
'with grant option' can trans these option to another users.
'%' any host may not include localhost sometimes.
;;  
	grant all privileges on *.* to "root"@"%" identified by "password";
	grant all privileges on *.* to 'root'@'%' identified by 'xxxxxx_remote' with grant option;
    grant select,update,intert,delete on logs.b_player_info  to 'exuxu'@'10.2.10.10' identified by 'xxxxxx';
;; orange mysql user	
	grant select/insert/update/delete on testdb.* to common_user@'%';
;; db developer 
	grant create/alter/drop/references/index/ on testdb.* to developer@'192.168.0.%';
	grant create temporary tables on testdb.* to developer@'192.168.0.%';			;; temporary table 
	grant create/show view on testdb.* to developer@'192.168.0.%';					;; show view sql code 
	grant create/alter routine on testdb.* to developer@'192.168.0.%'; 				;; Procedure 
	grant execute  on testdb.* to developer@'192.168.0.%';							;; Function

	grant all privileges on testdb to dba@'localhost'       ;; general  dba
	grant all on *.* to dba@'localhost'             ;; advance  dba
	revoke all on *.* from dba@localhost;           ;;Remove competence
	GRANT USAGE ON *.* TO 'dummy'@'localhost';        ;;login only with even select
 	drop user 'username'@'localhost';		;;delete mysql user
	rename user 'name1'@'%' to 'nam2'@'%';		;;rename mysql user
	set password for 'username'@'localhost' = password('userpassword');		;;change password of mysql suer

3.[Show something]

	show grants;                      ;;Competence
	show grants for dba@localhost;
	
	SHOW VARIABLES LIKE 'character_set_%';    ;;Character set
	
	select `name` from mysql.proc where db = 'your_db_name' and `type` = 'PROCEDURE';	        ;;Procedure
	show procedure status;

	select `name` from mysql.proc where db = 'your_db_name' and `type` = 'FUNCTION';        ;;Function
	show function status;

	show create procedure proc_name;            ;;create procedure	
	show create function func_name;

	SELECT * from information_schema.VIEWS        ;;create view	
	SELECT * from information_schema.TABLES 	

	SHOW TRIGGERS [FROM db_name] [LIKE expr]        ;;trigger
	SHOW TRIGGERS\G
	SELECT * FROM information_schema.triggers  
	
	show engines;					;;engines
	show variables like '%storage_engine%';

4.[character setting]
;;show table status
show table status from dbname  like 'tablename';
show full columns from dbname.tablename;
;;show character set 
SHOW VARIABLES LIKE 'character_set_%';
		character_set_client
		character_set_connection
		character_set_database
		character_set_server
;;show collate character set
show character set;

;;setting character set 
	/etc/my.cnf
	[mysql]
	default-character-set=utf8
	[mysqld]
	character_set_server=utf8
	collation-server=utf8_general_ci
	default-character-set=utf8


5.[sql slow query]
show variables like "%slow%"; 
;;open slow query log and query time
	set global long_query_time=5; 
	set global slow_query_log='ON'; 
;;modify config of "my.cnf"
	long_query_time = 5  
	log-slow-queries = /var/log/mysql/mysql-slow.log  	

	
6.[Mysql connect failed, mysql.sock not exists ?]
mysql -h 127.0.0.1 
	use tcp/ip protocol,it need refer to the connect port like '3306':" mysql -h 127.0.0.1 3306"
mysql -h localhost
	use unix socket 
Mysql clinet connect mysql server through   socket ,relate files is 'mysql.sock',if it doesn't exists,the mysql server need restart.
If cann't restart it instantly,try this "mysql   -u root -p -h localhost --protocol tcp  ",it means change connect protocol to tcp,but not socket.


7.[Mysql root password forget ?] 
	service mysqld stop			 ;; OR  “mysqladmin -u root -p shutdown”
	/usr/bin/mysqld_safe --skip-grant-tables & 	;;mysql login  without check user grants
	mysql
	>>update mysql.user set password=password('xxxxxx') where user='root' and host='localhost';
	>>flush privileges;
	>>exit
	service mysqld restart

8.LOG
	
	log-err	 
		 show variables like 'log_error';
	log	
		 show variables like 'log_%'; 
	log-slow-queries
		 show variables like "long_query_time";
		 show status like "%slow_queries%";
		 show variables like "%slow%";
	log-update  
	log-bin		 
		 show binary logs;
		 show master logs;
		 show master status;
		 mysqlbinlog mysql-bin.000017;		;;Read  binlog content

[mysqld]	
log=/data/mysqllog/mysqlcmd.log			;;recommand not record for large  query
log-err=/data/mysqllog/mysqlerr.log		
log-slow-queries=/data/mysqllog/mysql-slow-query.log
long_query_time=5
log-update=/data/mysqllog/mysql-update.log
log-bin=/data/mysqllog/mysql-bin.log
	
[mysqld_safe]
log-error=/data/mysqllog/mysqld_safe.log

9.Backup
------------------------------
#!/bin/bash
#File: /data/crontab/backup_db.sh 
#Usage : backup dyqlb database
#Content: zip the dyqlb database,move to the backup dir,then delete the backup file 5 days before 
#Author: exuxu

dt=`date +%Y%m%d%H%M%S`
bkdir=/data/backup

/usr/local/mysql/bin/mysqldump -uusername -ppassword --databases  databasename | gzip -9 > /data/backup/mysql_backup.$dt.gz
;;cd /data/backup
;;/usr/local/mysql/bin/mysqldump -uusername -ppassword --databases  databasename  > tmp.sql
;;tar czf mysql_backup.$dt.tar.gz tmp.sql 		;;with untar"tar xzf  mysql_backup.$dt.tar.gz  "
;;rm -f tmp.sql
cd /data/backup
find  $bkdir  -name "mysql_backup.*.gz" -mtime +5 -exec rm {} \;  &> /dev/null 
------------------------------
crontab -e
	0 4 * * * /data/crontab/backup_db.sh
	
10.Security setting
~Iptables 
 	iptables -A INPUT -p tcp -s xxxx.xxxx.xxxx.xxxx/24 --dport 3306 -j ACCEPT
 	iptables -P INPUT DROP
~port setting
	[mysqld]
	port=3306
~mysql client connection number limit
	[mysqld]
	max_user_connections 2
~passwords policy
	mysql password，web password
mysql deamon running  account
mysql permission with read(4) and write(2) without execution(1). 
Chrooting Enviroment
histroy commands
	cat /dev/null > ~/.bash_history

~In MySQL:
	user->db->tables_priv->columns_pri
 
user:
	GRANT OPTION	
			GRANT select privileges ON db1.tb1 TO 'name1' ;
			GRANT select ON db1.tb1 TO 'name1' WITH GRANT OPTION;
			name1: GRANT select ON db1.tb1 TO 'name2' WITH GRANT OPTION; 
	REFERENCES
	ALTER ROUTINE/CREATE ROUTINE/EXECUTE
	FILE
	CREATE TEMPORARY TABLES
	LOCK TABLES
	CREATE USER
	PROCESS
	RELOAD			flush-hosts, flush-logs, flush-privileges, flush-status, flush-tables, flush-threads, refresh, reload
	REPLICATION CLIENT
	REPLICATION SLAVE
	SHOW DATABASES
		/etc/init.d/mysql start --skip-show-database		
	SHUTDOWN
		>>grant shutdown on  *.* to 'username'@'hostip';
		$ mysqladmin -uusername shutdown
	SUPER

DB
	Drop                 
	Grant               
	References             
	Create_data/tmp_table          
	Lock_tables             
	Create_routine         
	Alter_routine        
	Execute         
	Event               
	Trigger 
 
