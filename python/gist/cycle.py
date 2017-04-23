#!/usr/bin/python
# -*- coding: UTF-8 -*-

import time


while True:
    print 'Cycle now ....'
    print time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())

    print '\t context ...'

    print '.... cycle ended\n'
    time.sleep(5)
