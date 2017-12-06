#!/usr/bin/python
# filename: send_mail.py
# Usage:
#   Used for zabbix callback
#   mv send_mail.py sendmail.sh && `sendmail.sh $MAIL_SENDTO $MAIL_SUBJECT $MAIL_MESSAGE`
# -*- coding: utf-8 -*-


import os
import sys
import smtplib
from email.mime.text import MIMEText


# --- mail configure ---
mail_to_list = sys.argv[1]
mail_host = "smtp.qq.com"
mail_user = "your_notify@qq.com"
# [CONFIG]
mail_pass = "xxxxx"
# [CONFIG], mail_pass 又称为授权码
mail_postfix = "qq.com"
mail_host_port = 465
# --- mail configure ---


def send_mail_core(mail_to_list, mail_title, mail_content):
    me = mail_user + "@" + mail_postfix
    msg = MIMEText(mail_content, _subtype='html', _charset='utf-8')

    msg["Subject"] = mail_title
    msg["From"] = me
    msg["To"] = mail_to_list
    try:
        s = smtplib.SMTP_SSL()
        s.connect(mail_host+':'+str(mail_host_port))
        s.login(mail_user, mail_pass)
        s.sendmail(me, mail_to_list, msg.as_string())
        s.close()
        return True
    except Exception as e:
        print(str(e))
        return False
if __name__ == "__main__":
    try:
        if len(sys.argv) == 4:
            mail_title = sys.argv[2]
            mail_content = "<p>" + sys.argv[3] + "</p>"
        else:
            mail_title = sys.argv[2]
            mail_content = "_zabbix center_"

        if send_mail_core(mail_to_list, mail_title, mail_content):
            print("[*] Send mail success: %s") % (mail_title)
            sys.exit()
        else:
            print("[*] Send mail failed: %s") % (mail_title)
    except Exception as e:
        print(str(e))
        raise

