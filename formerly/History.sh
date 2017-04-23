#!/bin/bash
# Usage: 
#	history bash command is unusable default,
#	Here,define it ,set its timestamp ,open it
#	Print the 80 ~ 90 history commands with read
# 	Count history use times with awk , sed

HISTFILE=~/.bash_history 
export HISTTIMEFORMAT='%F %T '
set -o history
history | head -n 100 | sed -n 90,100p  | while read line
do
	echo $line
done
echo '~~~~~~~~~~~~~'
history | awk '{print $2}' | sort | uniq -c | sort -k1,1rn -k2
history | sed "s#^\s\+[0-9]\+\s\+##g" | grep -oP "(?<=^|\|)\w+"|sort |uniq -c| sort -k1,1nr -k2
#history
#    	$HISTCMD
#    	$HISTCONTROL
#    	$HISTIGNORE
#    	$HISTFILE
#    	$HISTFILESIZE
#    	$HISTSIZE
#    	$HISTTIMEFORMAT (Bash, ver. 3.0 or later)
#    	!!
#    	!$
#    	!#
#    	!N
#    	!-N
#    	!STRING
#    	!?STRING?
#    	^STRING^string^

#date=`date +%Y%m%d`
#ssh2count=`cat /var/log/secure | grep 'ssh2' |awk -F 'from ' '{print $2}' | awk -F 'port' '{print $1}' |  sort | uniq -c | sort -k1,1rn -k2 | head -n 10`
#webcount=`cat  /usr/local/apache2/logs/access_log.$date | awk -F ' ' '{print $1}' |  sort | uniq -c | sort -k1,1rn -k2 | head -n 10`
#webcount2=`cat /usr/local/apache2/logs/access_log.$date | ( while read arg; do awk -F ' ' '{print $1}' ; done ) |   sort | uniq -c | sort -k1,1rn -k2 | head -n 10`
