#!/usr/bin/env python
import urllib2
import wechat_push
import datetime
from bs4 import BeautifulSoup


# URL = "http://free.apprcn.com/"
URL = "http://free.apprcn.com/category/mac/"
request = urllib2.Request(URL)
urlhandle = urllib2.urlopen(request, None, timeout=20)
page_context = urlhandle.read()
soup = BeautifulSoup(page_context, "html.parser")


entries_title = soup.select("#content_area .entry-title")
entries_time = soup.select("#content_area .thetime")
entries_content = soup.select("#content_area .entry-content")
entries_num = len(entries_title)
title = []
content = []
times = []
for x in range(0, entries_num - 1):
    title.append(entries_title[x].get_text())
    times.append(entries_time[x].get_text())
    content.append(entries_content[x].get_text().replace("Read More...", ""))

cons = ""
for x in range(0, entries_num - 1):
    cons = cons + " (" + times[x] + ") "
    cons += title[x]
    cons += "\n"
    cons += content[x]

wp = wechat_push.wechat_push()
dt_now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M")
wp.push("APP push " + dt_now, cons)
