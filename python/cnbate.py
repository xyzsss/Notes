import urllib2
from bs4 import BeautifulSoup
import time
import datetime
import requests
import sys
from requests.exceptions import ConnectionError


def wechat_psuh(text, desp):
    URL = "http://sc.ftqq.com/SCU1154T31ffa6b7a2782d8ed21c4345a8cb794a577bd1a2b9eec.send"
    parameters = (('text', text), ('desp', desp))
    r = requests.get(URL, params=parameters)



get_failed_flag = 0
for page_num in range(512579, 50000000):
    URL = "http://www.cnbeta.com/articles/" + str(page_num) + ".htm"
    request = urllib2.Request(
                URL, headers={'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20100101 Firefox/12.0'})
    request.add_header('Referer', "http://www.cnbeta.com/")
    try:
        try:
            urlhandle = urllib2.urlopen(request, None, timeout=20)
        except Exception, err:
            print "Request TIMEOUT for " + URL
            continue
    except ConnectionError:
        print "Request failed!" + URL
    page_context = urlhandle.read()
    soup = BeautifulSoup(page_context, "html.parser")
    title = soup.select('title')[0].get_text().replace("_cnBeta.COM", "").encode("utf-8")
    content = content = soup.select('.article_content')
    if len(content) == 0:
        get_failed_flag += 1
        print "Being robot ??? " + URL + "  get failed!"
        if get_failed_flag > 20:
            title = "PAGE GET FAILED TOO MANY TIMES!"
            content = "Something was wrong with the script ,please check!"
            wechat_psuh(title, content)
            sys.exit(1)
        continue
    else:
        release_date = (soup.select('.date')[0].get_text()).encode("utf-8")[:-6]
        dt_now = datetime.datetime.now().strftime("%Y-%m-%d %H")
        if dt_now == release_date:
            title = "CNBATE NEWS UPDATE STOP FOR ONE HOUR FROM NOW."
            content = "WAITING FOR THE TIME FLYING ...."
            wechat_psuh(title, content)
            time.sleep(3600)
        content = release_date + soup.select('.article_content')[0].get_text().encode("utf-8")
        get_failed_flag = 0
    if title == 'cnBeta.COM_\xe4\xb8\xad\xe6\x96\x87\xe4\xb8\x9a\xe7\x95\x8c\xe8\xb5\x84\xe8\xae\xaf\xe7\xab\x99':
        pass
    else:
        wechat_psuh(title, content)
        print "Push successed!" + title
    time.sleep(10)
