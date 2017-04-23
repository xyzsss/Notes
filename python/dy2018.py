import sys
import os
import time
from bs4 import BeautifulSoup
import urllib2
import MySQLdb
import socket
import datetime


class dy2018_kali():

    def __init__(self):
        reload(sys)
        sys.setdefaultencoding('utf-8')
        self.page_start = 91854
        self.page_end = 96890
        self.agent = 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0)'\
            ' Gecko/20100101 Firefox/12.0'
        self.log_file_name = 'dy2018.log'
        self.log_file_path = 'log'
        self.log_file = self.log_file_path + "/" + self.log_file_name
        self.urllib2_header = "http://www.dy2018.com/"

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
            "localhost", "pytest", "haha233", "dy2018", charset='utf8')
        cursor = con.cursor()
        cursor.execute(
            'INSERT INTO film (name, rank, redate, content, downlinks)' +
            ' VALUES (%s, %s, %s, %s, %s)', (
                name.decode('utf-8'), rank.decode('utf-8'),
                redate.decode('utf-8'), content.decode('utf-8'),
                links.decode('utf-8')))
        con.commit()
        con.close()

    def get_current_datetime(self):
        dt_now = datetime.datetime.now()
        datetime_now = dt_now.strftime("%Y-%m-%d %H:%M:%S")
        return datetime_now

    def print_log(self, URL, print_code):
        dt_now = self.get_current_datetime()
        if print_code == 1:
            print "\t" + dt_now + "\tThe page ", URL, " stored."
        elif print_code == 2:
            print "\t" + dt_now + "\tThe page ", URL, " is EMPTY!!!"
        else:
            print "Print CODE not defined!"

    def print_error_page(self, URL, error):
        dt_now = self.get_current_datetime()
        print dt_now + "\tThe page", URL, " was " + error

    def check_log_file(self):
        if not os.path.isdir(self.log_file_path):
            os.makedirs(self.log_file_path)

        if os.path.isfile(self.log_file):
            os.utime(self.log_file, None)
        else:
            open(self.log_file, 'a').close()

    def log_unhandled_record(self, URL, reason):
        self.check_log_file()
        dt_now = self.get_current_datetime()
        with open(self.log_file, 'a') as f:
            f.write("\n" + dt_now + "\n")
            f.write(reason + URL)

    def start_crawing(self):
        for page in range(self.page_start, self.page_end):
            URL = "http://www.dy2018.com/i/" + str(page) + ".html"
            request = urllib2.Request(
                URL, headers={'User-Agent': self.agent})
            request.add_header('Referer', self.urllib2_header)
            try:
                try:
                    response = urllib2.urlopen(request, None, timeout=20)
                except Exception, err:
                    self.log_unhandled_record(URL, str(err))
                    self.print_error_page(URL, str(err))
                    continue
            except socket.timeout:
                self.log_unhandled_record(URL, "Socket time out.")
                time.sleep(20)
                continue
            try:
                context = response.read()
            except Exception, err:
                self.log_unhandled_record(URL, str(err))
                self.print_error_page(URL, str(err))
                time.sleep(30)
                continue
            try:
                page_context = context.decode('gbk').encode('utf-8')
            except:
                page_context = context.decode('gb18030').encode('utf-8')
            soup = BeautifulSoup(page_context, "html.parser")
            if str(soup) != "":
                name = soup.title.text
                rank = self.get_rank(soup)
                redate = self.get_date(soup)
                ftype = self.get_type(soup)
                content = self.get_content(soup)
                links = self.get_links(soup)
                self.new_film_record(name, rank, redate, ftype, content, links)
                self.print_log(URL, 1)
            else:
                self.print_log(URL, 2)
            time.sleep(6)

if __name__ == '__main__':
    dy = dy2018_kali()
    dy.start_crawing()
