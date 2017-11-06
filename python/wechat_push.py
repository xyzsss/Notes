'''
 Author : exuxu
 Class name : wechat_push.py
 Usage :
        Include this class the use it to push message to wechat of exuxus
'''
# -*- coding=utf-8 -*-
import requests

version = '0.1'


class wechat_push():

    def __init__(self):
        pass

    def push(self, text, desp):
        URL = "http://sc.ftqq.com/SCU1154T31ffa6b7a2782d8ed21c4345a8cb794a577bd1a2b9eec.send"
        parameters = (('text', text), ('desp', desp))
        requests.get(URL, params=parameters)
