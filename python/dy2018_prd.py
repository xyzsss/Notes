from bs4 import BeautifulSoup
import urllib2
import sys
import MySQLdb
import time
import threading

reload(sys)
sys.setdefaultencoding('utf-8')



def check_craw():
    while True:
        time.sleep(5)
        con = MySQLdb.connect("localhost", "pytest", "qwer!234", "dy2018", charset = 'utf8')
        cursor = con.cursor()
        cursor.execute('select count(id) from dy2018.film ;')
        film_num = str(cursor.fetchone()[0])
        print '\n\t\tFilm number is ' + film_num + '\n'


def craw_dy2018():
    # for page in range(91854, 96772):
    for page in range(92355, 96772):
        # Mon Apr 25 22:10:57 CST 2016
        URL = "http://www.dy2018.com/i/" + str(page) + ".html"
        try:
            urlhandle = urllib2.urlopen(URL)
            page_context = urlhandle.read().decode('gbk').encode('utf-8')

            # page_context = urlhandle.read().encode('gbk', errors='replace').
            #   decode('gbk').encode('utf-8')
            # show bug in page 92454

            soup = BeautifulSoup(page_context, "html.parser")

            name = soup.title.text
            rank = soup.select('.position  .rank')
            if (len(rank) == 0):
                rank = ''
            else:
                rank = rank[0].get_text()

            date = soup.select('.position  .updatetime')
            if (len(date) == 0):
                date = ''
            else:
                date = date[0].get_text()
            # date = datetime.datetime.strptime(date, '%Y-%m-%d')
            type = soup.select('.position')
            if (len(type) == 1 or len(type) == 0):
                type = ''
            else:
                type = type[0].find_all('span')[1].get_text()

            context = ""
            for con in soup.find_all("p"):
                context += con.get_text()
                context += '<br/>'

            downlinks = ""
            for link in soup.find_all('tbody'):
                downlinks += link.get_text().strip()
                downlinks += "|||"

            con = MySQLdb.connect("localhost", "pytest", "qwer!234", "dy2018", charset = 'utf8')
            cursor = con.cursor()
            cursor.execute('INSERT INTO film (name, rank, redate, content, downlinks) VALUES \
                (%s, %s, %s, %s, %s)', (name.decode('utf-8'), rank.decode('utf-8'), date.decode('utf-8'), context.decode('utf-8'), downlinks.decode('utf-8')))
            con.commit()
            con.close()
            print "\t\tThe page ", URL, " stored."

            time.sleep(5)
        except urllib2.HTTPError, e:
            print "\t\tSorry for page ", URL, " 404 "


threads = []
threads.append(threading.Thread(target=craw_dy2018))
threads.append(threading.Thread(target=check_craw))

for t in threads:
    t.setDaemon(True)
    t.start()
t.join()


print '\n\t\tCrawling over \n'
