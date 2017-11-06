#!/bin/bash
# used in crontab
# running every minutes
# for check local dev blog running status

LOG_FILE="/tmp/blog_running_check.log"

PORT="4000"
PROCESS_NUM=`ps -ef|grep jekyll|grep -v 'grep'|wc -l`
PORT_NUM=`netstat -ant -p tcp|grep ${PORT}|wc -l`

if [ $PORT_NUM -eq 1 ] && [ $PROCESS_NUM -eq 1 ];
then
    echo 'running status ok!'   >> $LOG_FILE 2>&1
else
    echo 'not running ? start it now...'  >> $LOG_FILE 2>&1
    cd /data/github/xyzsss.github.io/
    nohup jekyll serve & >> $LOG_FILE 2>&1
fi
