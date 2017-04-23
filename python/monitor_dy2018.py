#!/usr/bin/env python
#
# update mysql.user set password=password('haha233')
# +where user='pytest' and host='localhost';
#

import MySQLdb
import time
import mail_monitor


def fetch_total_num():
    con = MySQLdb.connect(
        "localhost", "pytest", "haha233", "dy2018", charset='utf8')
    cursor = con.cursor()
    cursor.execute('select count(id) from dy2018.film ;')
    total_num = cursor.fetchone()[0]
    cursor.close()
    con.close()
    return total_num

film_num = 0
mail_times = 3
while True:
    if film_num == 0:
        film_num = fetch_total_num()

    print 'start num: ' + str(film_num)
    time.sleep(600)    # 10 minutes

    tmp_num = fetch_total_num()
    print 'current num: ' + str(tmp_num) + '\tflag: ' + str(film_num)

    if tmp_num == film_num:
        mm = mail_monitor.mail_monitor()
        mail_msg = "scrapy project for film 2018 is stopped for some reason."
        subject = 'Scrapy 2018 proj is stopped.'
        mm.send_mail(mail_msg, subject)
        if mail_times == 3:
            break
        else:
            mail_times += 1
    else:
        film_num = tmp_num
        continue
    print 'end ' + str(film_num)
