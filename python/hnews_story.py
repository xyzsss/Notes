import urllib2
import json
import wechat_push
import datetime
import time
from bs4 import BeautifulSoup



def get_page(url):
    return False

new_url = "https://hacker-news.firebaseio.com/v0/newstories.json"
request = urllib2.Request(new_url)
urlhandle = urllib2.urlopen(request, None, timeout=20)
page_context = urlhandle.read()
id_list = json.loads(page_context)
story = ""
while(len(id_list) > 0):
    cur_id = id_list.pop()
    item_url = "https://hacker-news.firebaseio.com/v0/item/" + str(cur_id) + ".json"
    item_request = urllib2.Request(item_url)
    item_urlhandle = urllib2.urlopen(item_request, None, timeout=20)
    item_json = item_urlhandle.read()
    item_dict = json.loads(item_json)
    if 'url' in item_dict:
        item_text = item_dict['url']
        url_content = get_page(item_text.encode('utf-8'))
        if url_content:
            item_text = url_content
    elif 'text' in item_dict:
        item_text = item_dict['text']
    else:
        item_text = "......"
    if 'score' in item_dict:
        item_score = str(item_dict['score'])
    else:
        item_score = '0'
    item_time = datetime.datetime.fromtimestamp(item_dict['time']).strftime('%Y-%m-%d %H:%M:%S')
    item_content = "[" + item_dict['type'] + "] :" + item_score + " || " + \
        item_dict['title'] + " || " + item_time + "\n\n" + item_text
    item_content += "\n\n"
    story += item_content

    # time.sleep(3)

wp = wechat_push.wechat_push()
wp.push('HN.news.PUSH', story)