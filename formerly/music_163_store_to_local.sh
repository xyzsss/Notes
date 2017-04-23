#!/bin/bash
# Scripts to get the music 163 vip album info ,Then result it in the mysql local.
# Source URL: http://music.163.com/#/member/album  ,hold down the space button to pull down to the page bottom. 

# bash for loop grammar
# #for i in `seq 1 10` ;do 	echo $i; done 

# Single command
# cat 1 | awk -F  '</li>'  '{ print $100 }'
# cat 1 | awk -F  '</li>'  "{ print $100 }"	#double quote is not work fine ?

# single line
# awk -F: '{name[NR]=$1}END{for(i=1;i<=NR;i++){print i,name[i]}}' /etc/passwd
# awk -F: 'for(i=1;i<=10;i++){print i}' /etc/passwd

logfile='/tmp/insert_163_vip_music_log.'`date +%Y%m%d`
echo > logfile
for t in `seq  1 3200`
do
	con=`cat /home/xyz/Desktop/1 | awk -F  '</li>'  "{ print $\`echo $t\` }"`
	singer=`echo $con | awk -F '</a>' '{print $4 }'|awk -F '>' '{print $4 }'`
	album=`echo $con| awk -F '</a>' '{print $3 }'|awk -F '>' '{print $4 }'`
	img=`echo $con| awk -F 'src=\"' '{print $2 }' |awk -F '\"' '{print $1}' | sed 's/?param=130y130//'`
	mysql -D timeline --default-character-set=utf8 -u root  -e "insert into music163 (singer,album,img) values ( \"$singer\",\"$album\",\"$img\" )"
	echo '\tInsert '$t' value successed!' >> $logfile  2>&1
done
echo  "\nAll 163 vip music info record finished！\n(Record $t album info )\n\n\t^_^ "

### mysql table 
	# CREATE TABLE music163 (
	# id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY UNIQUE,
	# singer VARCHAR(30) NOT NULL,
	# album VARCHAR(30) NOT NULL UNIQUE,
	# img VARCHAR(200),
	# update_date TIMESTAMP,
	# INDEX (singer,album)
	# );

### Bash to MySQL
# mysql -D [db name] -u [user] -p[pass] -e "[mysql commands]"
# mysql -D clients -u root -pSeCrEt -e "show tables"

### Table operation
# truncate table table_name;	#Restore the auto_increment value
# delete from table_name;		#Unrestore the auto_increment value

# MySQL insert url and string need quotas .
# Reverse breaks used in reverse breaks used with the Black slash after to reverse.

# Date
#	logfile='/tmp/insert_163_vip_music_log'`date +%Y%m%d-%H%M%S`
