#!/usr/lib/env bash

# Full backup the sqlite db file
# usage:  
#    crontab -e 
#    1 15 * * * /path/to/file/of/backup-sqlite-db.sh > /dev/null 2>&1
# author:  exuxu

DB_FILE="/Users/mike/github/TimeEvent/timeEvent.db"
FILES_KEEP_DIR="/backup"

DT=`date +%Y%m%d_%H%M%S`

# check_backup_file
if [ -s ${DB_FILE} ];then
    echo 'Check backup file ok.'
else
    echo "File to backup ${DB_FILE} not exists or empty,backup failed!"
    exit 1
fi

# check_dest_backup_dir
if [ -d ${FILES_KEEP_DIR} ];then
    if [ -w ${FILES_KEEP_DIR} ];then
        echo 'Check dest directory ok.'
    else
        echo "Curr user $USER have no write permission to dest directory,backup failed!"
        exit 1
    fi
else
    echo "directory to keep file named ${DB_FILE} not exists,backup failed!"
    exit 1
fi

# generate_new_file_name
ORI_FILE_NAME=`echo ${DB_FILE} | awk -F '/' '{print $NF}'`
NEW_FILE_NAME="${ORI_FILE_NAME}.${DT}"
NEW_DB_FILE="${FILES_KEEP_DIR}/${NEW_FILE_NAME}"

# backup_action
cp ${DB_FILE} ${NEW_DB_FILE}


# backup action check
echo "${DT}"
if [ $? == 0 ];then
    echo 'Backup Successful!'
else
    echo 'Backup failed,please check.'
    exit 1
fi