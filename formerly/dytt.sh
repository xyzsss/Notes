#!/bin/bash
#Filename:dytt.sh
#Usage:get the links from dytt
#time:2014.11.14 

## ip to strings 
b=""
lo_ip="110.86.14.98$b"	

##　get proxy mode
export http_proxy=http://122.224.152.179:80

## get local machine public ip address,sleep for time relay
ip=`curl ipecho.net/plain ; echo`	
sleep 6


if [ $ip =  $lo_ip ]
then
	echo 'still here.'
else
	#if can use proxy,then start get url 
	for nu  in `seq 91865 94000`
	do
		#step 
		#	1.use 'wget' get html source page
		#	2.deal with local html file ,get its title,name,info,links,url with regular express

		wget  http://www.dy2018.com/i/$nu.html
		enca  -L zh_CN -x UTF-8 $nu.html 
		if test  -e $nu.html ;then
			#if  html file get success,then deal ,or it will get nothing if page no be visit
			url="http://www.dy2018.com/i/$nu.html"
			title=`grep 'title_all' $nu.html | awk -F '<' '{print $3}' | sed 's/h1>//'`
			name=`echo $title | sed 's/^.*《//'|sed 's/》.*$//'`
			
			#get information
			info=`cat $nu.html  | grep '◎' | sed 's/<[^>]*>//g'  | sed 's/&nbsp;/ /g' |sed 's/&amp;/ /' |sed 's/&middot;//'| grep  -v '影片截图'  |tr -d '\n\r'`
			if [ ${#info} -lt 10  ] 
			then
	            info=`cat $nu.html  | grep  '【' | sed 's/<[^>]*>//g'  | sed 's/&nbsp;/ /g' |sed 's/&amp;/ /' |sed 's/&middot;//'| grep  -v '影片截图'  |tr -d '\n\r'`
			fi

			## get links,the link may be store in the line next to the 'tag' line
			links=`cat $nu.html  | grep 'break-word' |  sed 's/<[^>]*>//g' | sed 's/&nbsp;//g' `

			##  get rid of blank space
			links=`echo ${links##*()}`
			if [ ${#links} -lt 10 ] 	
			then
				#for the links line is not the same to the tag 'break-wrod'
				links=`cat $nu.html | sed  -n '/break-word/{n;p;}' | sed 's/<[^>]*>//g'`
			fi

			## insert links info int MySQL
			mysql -u exuxu  -e "use dytt; insert into dytt (name,title,infoms,links,url) values ('$name','$title','$info','$links','$url')"
			sleep 1
			rm -f $nu.html
		else
			echo '..no ..... exists...'
		fi
		#  
		sleep 1
	done

fi
### --->dytt.sh done





###Create Database and Table 
#1.db
CREATE DATABASE dytt  DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
#2.tb
DROP TABLE IF EXISTS `dytt`;
CREATE TABLE `dytt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(300) NOT NULL,
  `title` text,
  `infoms` text,
  `links` longtext,
  `url` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`) USING HASH
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


