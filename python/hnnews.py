#!/usr/bin/python
# -*- coding: UTF-8 -*-

import requests
import re
import sys

reload(sys)
sys.setdefaultencoding('utf-8')

resfile = "/tmp/hnews.txt"
ori_url = "https://news.ycombinator.com"

user_agent = 'Mozilla/4.0 (compatible; MSIE 5.5; Windows NT)'
headers = {'User-Agent': user_agent}

# r = requests.get("https://news.ycombinator.com/newest")
r = requests.get(ori_url, timeout=20.00)

urls = re.findall('http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+', r.text)

f = open(resfile, 'a')
# for url in urls:
    # print url
for url in urls:
    if str(url).find('ycombinator') > 0:
        pass
    elif str(url).find('youtube') > 0:
        pass
    else:
        # tmpurl = requests.get(str(url))
        try:
            tmpurl = requests.get(str(url))
            if tmpurl.status_code == 200:
                text = tmpurl.text+"<br/><br/>@==xyzsss==@<br/><br/>"
            else:
                text = "<h2>"+url+"</h2><br/> URL OPEN FAILED!<br/>"
        except requests.exceptions.RequestException as e:
            text = str(e)
        f.write(text)

f.close()
# print r.status_code
# print r.encoding
# print r.headers['content-type']
print '~~~ DONE! ~~~'
