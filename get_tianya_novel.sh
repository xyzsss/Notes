#!/bin/bash

# J M
PAGE_START=1
PAGE_END=155
OUTPUT_FILE=coffice_story.txt



echo -e "\t Now start download the novel content"

for pg in `seq $PAGE_START $PAGE_END`;
do
	PAGE=$pg
	# http://bbs.tianya.cn/post-books-85465-1.shtml
	URL=http://bbs.tianya.cn/post-books-85465-$PAGE.shtml
	FILE=post-books-85465-$PAGE.shtml
	wget -t 2 -T 10 -P /tmp  $URL
	cat /tmp/$FILE | grep -A 2 'bbs-content\|uid=' | grep -v "\-\-" | grep -v '时间：' | grep -v 'bbs-content' |sed 's/<\/span>//' |sed  's/<span>//' |sed 's/<\/div>//'| sed 's/<a [^>]*>//' |sed 's/<\/a>//' |sed 's/<br>//g'  | sed 's/<strong class="host">楼主<\/strong>/=======/'   | grep -v '^$' | grep -A 3 '====' | grep -v "====" >> $OUTPUT_FILE
	rm -f /tmp/$FILE
	sleep 2
	
done

