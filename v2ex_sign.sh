#!/bin/bash
# 2017-04-23 14:00:15
#
#crontab -e
# 1 6 * * * /home/exuxu/daily/v2ex/cron_v2ex.sh
# https://raw.githubusercontent.com/lqccan/v2ex-sign/master/v2ex.py

echo
echo `date` >> /tmp/v2sign.log 
source /home/exuxu/py3/bin/activate
python /home/exuxu/daily/v2ex/v2ex.py >> /tmp/v2sign.log 2>&1
deactivate
