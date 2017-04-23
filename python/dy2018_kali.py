import sys
import time
from bs4 import BeautifulSoup
import urllib2
import MySQLdb
import datetime


class dy2018_kali():

    def __init__(self):
        reload(sys)
        sys.setdefaultencoding('utf-8')

        # self.page_start = 91854
        self.page_start = 93008
        self.page_end = 96890

    def get_rank(self, soup):
        rank = soup.select('.position  .rank')
        if (len(rank) == 0):
            rank = ''
        else:
            rank = rank[0].get_text()
        return rank

    def get_date(self, soup):
        date = soup.select('.position  .updatetime')
        if (len(date) == 0):
            date = ''
        else:
            date = date[0].get_text()
        return date

    def get_type(self, soup):
        ftype = soup.select('.position')
        if (len(ftype) == 1 or len(ftype) == 0):
            ftype = ''
        else:
            ftype = ftype[0].find_all('span')[1].get_text()
        return ftype

    def get_content(self, soup):
        context = ""
        for con in soup.find_all("p"):
            context += con.get_text()
            context += '<br/>'
        return context

    def get_links(self, soup):
        downlinks = ""
        for link in soup.find_all('tbody'):
            downlinks += link.get_text().strip()
            downlinks += "|||"
        return downlinks

    def new_film_record(self, name, rank, redate, ftype, content, links):
        con = MySQLdb.connect(
            "localhost", "pytest", "qwer!234", "dy2018", charset='utf8')
        cursor = con.cursor()
        cursor.execute(
            'INSERT INTO film (name, rank, redate, content, downlinks)' +
            ' VALUES (%s, %s, %s, %s, %s)', (
                name.decode('utf-8'), rank.decode('utf-8'),
                redate.decode('utf-8'), content.decode('utf-8'),
                links.decode('utf-8')))
        con.commit()
        con.close()

    def print_inert_log(self, URL):
        dt_now = datetime.datetime.now()
        datetime_now = dt_now.strftime("%Y-%m-%d %H:%M:%S")
        print "\t\t" + datetime_now + "The page ", URL, " stored."

    def start_crawing(self):
        for page in range(self.page_start, self.page_end):
            URL = "http://www.dy2018.com/i/" + str(page) + ".html"
            try:
                urlhandle = urllib2.urlopen(URL)
                page_context = urlhandle.read().decode('gbk').encode('utf-8')
                soup = BeautifulSoup(page_context, "html.parser")
                # 93008 is None
                if str(soup) != "":
                    name = soup.title.text
                    rank = self.get_rank(soup)
                    redate = self.get_date(soup)
                    ftype = self.get_type(soup)
                    content = self.get_content(soup)
                    links = self.get_links(soup)
                    self.new_film_record(
                        name, rank, redate, ftype, content, links)
                    self.print_inert_log(URL)
                else:
                    print "\t\tFor empty page", URL
                time.sleep(5)
            except urllib2.HTTPError:
                print "\t\tSorry for page ", URL, " 404 "

if __name__ == '__main__':
    dy = dy2018_kali()
    dy.start_crawing()
