#coding=utf-8 
import urllib2
import re
import time
import socket

#   num: url　start page number
#   no_conext_flag: flag to  none context page
num = 394161
no_context_flag = 0


while 1:
 
    page_url = "http://www.cnbeta.com/articles/"
    page_url += str(num)
    page_url += ".htm"
    #print page_url

    request = urllib2.Request(page_url)
    request.add_header('User-agent', 'Mozilla/5.0 (Linux i686)')    

    try:
        response = urllib2.urlopen(request,timeout = 8)
        #up_time = response.info()['Last-Modified']
        #Thu, 14 May 2015 09:11:54 GMT

        f = open('tmp_cnbate', 'w')
        f.write(response.read())
        f.close()

        f = open('tmp_cnbate','r')
        content=f.read()
        match = re.findall(r'<title>.*</title>', content)
        page_time = re.findall(r'<span class="date">.*?</span>', content)

        if match and page_time:
            #page_time = re.findall(r'<span class="date">.*?</span>', content)
            page_time = re.sub('<.*>','',re.sub('</?span>', '', page_time[0]))
            title = re.sub('_cnBeta.COM','',re.sub('</?title>', '', match[0]).decode("utf-8"))
            if title == 'cnBeta.COM_中文业界资讯站'.decode('utf-8'):
                print '\t-\n'
            else:
                print title
                print "\t" + page_time + "\t" + page_url + "\n"

                #!/usr/bin/python  
                #coding: utf-8  
                import smtplib  
                from email.mime.text import MIMEText  
                from email.header import Header  
                  
                sender = 'xxx'  
                receiver = 'xxx'  
                subject = title  
                smtpserver = 'smtp.163.com'  
                username = 'xxx'  
                password = 'pppppp'  
                  
                # msg = MIMEText('Hi,Is there','We are con!','utf-8') #中文需参数‘utf-8’，单字节字符不需要  
                # msg['Subject'] = Header(subject, 'utf-8')  
                contexts = '<html><h1>'+title+'</h1><br/><p><a href='+page_url+">"+page_time+'</a><p></html>'
                msg = MIMEText(contexts,'html','utf-8')  
                  
                msg['Subject'] = subject

                smtp = smtplib.SMTP()  
                smtp.connect('smtp.163.com')  
                smtp.login(username, password)  
                smtp.sendmail(sender, receiver, msg.as_string())  
                smtp.quit()  
            no_context_flag = 0

        else:
            print "\tPage:"+str(num)+" ,No context:" + str(no_context_flag) +"\n"
            no_context_flag = int(no_context_flag) + 1
            if no_context_flag == 8:
                print "Is't time to waite website update now!!(about half an hour)"
                time.sleep(1800)

        f.close()

        ###for request too frequency,sleep for 3 seconds
        ###every time request,then start a new page
        time.sleep(10)
        num += 1
    except  urllib2.URLError, e:
        print type(e) 
    except socket.timeout as e:
        print "There was an error: %r" % e

    #   print 
    #   response.read()   

    
