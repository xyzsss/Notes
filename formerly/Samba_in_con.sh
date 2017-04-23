#!/bin/bash
# samba server Installation and Configuration
#Time:2014.12.17

yum -y install samba
useradd webs -s /sbin/nologin
smbpasswd -a webs 
##require user input from  keyboard
chown -R webs:root /var/www/html
echo -e "[share]\ncomment = Used for upload web file\npath = /var/www/html\nwritable = yes\nvalid users = webs" >> /etc/samba/smb.conf
service smb start
chkconfig --levels 235 smb on
testparm
