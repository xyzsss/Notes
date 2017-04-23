#!/bin/bash
#Installation of DenyHosts
# run as 'root' default
  #Denyhosts 
  ## protect from ssh blasting ,It analysis file /var/log/secure,if find abnormal ssh request,the add its ip to  /etc/hosts.deny  
  ## Otherwise,it will unblock the ip while sometimes.
  ## official website: http://denyhosts.sourceforge.net/
# Time:2014.12.16
echo "=====Scripts execution starts====="
wget http://sourceforge.net/projects/denyhosts/files/denyhosts/2.6/DenyHosts-2.6.tar.gz
tar zxvf DenyHosts-2.6.tar.gz
cd DenyHosts-2.6
yum install python -y
python setup.py install

cd /usr/share/denyhosts/
cp denyhosts.cfg-dist denyhosts.cfg
cp daemon-control-dist daemon-control
cp denyhosts.cfg denyhosts.cfg.orign
cat denyhosts.cfg.orign |grep -v '^#' | grep -v '^$' | grep -v '^PURGE_DENY.*$' | grep -v '^PURGE_THRESHOLD.*$' | grep -v '^DENY_THRESHOLD_INVALI.*$' | grep -v  '^DENY_THRESHOLD_VALID.*$' | grep -v '^DENY_THRESHOLD_ROOT.*$'  > denyhosts.cfg
echo -e  "   ######### mod by user #########   \nPURGE_DENY = 1w\n#3m,5h,2d,8w,1y\nPURGE_THRESHOLD =  5\n#Max try connect times,or will deny forever\nDENY_THRESHOLD_INVALID = 5\n#Try connect with not exists account max times\nDENY_THRESHOLD_VALID = 5\n#Try with exists account max times\nDENY_THRESHOLD_ROOT =1\n#Max times root try connect" >> denyhosts.cfg
./daemon-control start

cd /etc/init.d
ln -s /usr/share/denyhosts/daemon-control denyhosts
chkconfig --add denyhosts
chkconfig --level 2345 denyhosts on
##OR:            echo '/usr/share/denyhosts/daemon-control start' >> /etc/rc.local
## more  /etc/hosts.deny
ps aux | grep deny| grep -v 'grep'
echo '====INSTALLATION FINISHED==='
