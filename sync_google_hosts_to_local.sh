#!/bin/bash
#
# This script is used for sync the hosts content from github to local hosts 
# You need run the script with "sudo" prefix
#

newline1='192.168.111.1   pi'

pre_check(){
    shasum_bin=`which shasum`
    if [ ! $? -eq 0 ];then
        echo '\n\t NO shasum found! script exit .'
    fi
}


download_hosts_file(){
    echo '\n\tDownloading the original file now ....'
    wget https://raw.githubusercontent.com/racaljk/hosts/master/hosts  -t 5 -c -O tmp.hosts > /dev/null 2>&1
    if [ ! $? -eq 0 ];then
        echo '\n\tCannot get source file ,exit now ...'
        exit 1
    fi
    echo '\n\tDownloading the original file compeleted! '
}


change_hosts_content(){
    source_hash=`$shasum_bin tmp.hosts | awk '{print $1}'`
    local_hash=`cat /etc/hosts| grep -v "$newline1" | $shasum_bin | awk '{print $1}'`
    echo '\nThe shasum value:\n\t'$source_hash'\n\t'$local_hash
    echo '\t\tNow,dealing ....'
    if [ "$source_hash" ==  "$local_hash" ];then
    	:
    else
    	echo $newline1 > /etc/hosts
    	cat tmp.hosts >> /etc/hosts
    fi
}

after_dealing(){
    rm -f tmp.hosts
    if [ ! $? -eq 0 ];then
        echo '\ntemp file tmp.hosts delete failed'
    fi
}

pre_check
download_hosts_file
change_hosts_content
after_dealing
echo '\n\t........ Update  hosts success ........\n'
