#!/bin/bash 
# eg:
#    1
#    2        ------->  ('1','2','3')
#    3
#
# Time: 2014.07.04
# Author: exuxu
#Support:files,chekc file exists

file_num=$#
if [ $file_num == 0 ];then
        echo  'Hey,  Sorry,No file to convert.'
else
        t=1
        while [ $t -le $file_num ];
        do
                file=$(eval echo \$$t)
                if [ -e $file ]
                then
                        cat $file | grep -v '^$' | sed ":a;N;s/\n/','/g;ta" | sed "s/^/('/" |sed "s/$/')/" > $file.txt
                        echo -e "\t\e[35m $file trans to $file.txt ,DONE ! \e[0m"
                else
                        echo "$file  not found -_-!"
                fi
                t=`expr $t + 1`
        done
        echo 
fi
echo '!...DONE...!'
