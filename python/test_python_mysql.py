#!/usr/bin/python

# 1.MySQL Server
# just install it
# 2.Python
# pip install BeautifulSoup4 request
# 3.MySQL-python
# apt-get install python-dev libmysqlclient-dev
# pip install MySQL-python
#  mysql:
# >>>create database dy2018;
# grant all privileges on *.* to "pytest"@"localhost" identified by "qwer!234";
# >>>flush privileges;
# 4.Code and Decode
# >>>SHOW VARIABLES LIKE 'character_set_%';


import MySQLdb

db = MySQLdb.connect("localhost", "pytest", "haha233", "dy2018")
cursor = db.cursor()
sql = "insert into film (name, rank, redate, content) values \
    ('test_name', '9.9', '2016-04-25', 'test context')"
'''
#show database;
# select User,Host from mysql.user;
'''
try:
    res = cursor.execute(sql)
    print '\t\tTotal values:', res
    if (res != 0):
        results = cursor.fetchall()
        for result in results:
            print '\t\t\t', result
        db.commit()
    else:
        print '\t[EMPTY VALUE]'
except:
    db.rollback()
db.close()
