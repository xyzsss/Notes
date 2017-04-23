#!/bin/bash

url=$1
wget $url
refile=`date +%Y-%m-%d_%H-%M-%S`

filename=`echo $url | awk -F '/' '{print $4}' `
img=`cat $filename |  grep 'src='  | awk -F 'src=' '{print $2}' | awk -F '"' '{print $2}'`

#img=`cat read-htm-tid-4128245.html |  grep 'http://bbs.xmfish.com/read-htm-tid-4128245.html'  | awk  -F 'src=' '{ print $2}' | awk -F '"' '{print $2}'`
#img=`cat read-htm-tid-4128245.html |  grep 'http://bbs.xmfish.com/read-htm-tid-685529.html'  | awk  -F 'src=' '{ print $2}' | awk -F '"' '{print $2}'`

for i in $img
do
	wget $i
	echo $i.download..over....!
done
mv *.jpg  tmp/
zip  $refile.zip tmp/
rm -f *.js *.html *.gif *.jpg.1 *.png
rm -f $filename
echo 'Finished!!!'
