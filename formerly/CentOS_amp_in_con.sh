#!/bin/bash
####################
 Setting
####################
ifconfig
dhclient
	#vi /etc/sysconfig/network-scripts/ifcfg-eth0
sed -i "s/ONBOOT=no/ONBOOT=yes/" /etc/sysconfig/network-scripts/ifcfg-eth0 
	#vi /etc/sysconfig/selinux
sed -i "s/SELINUX=enforcing/SELINUX=disabled/" /etc/sysconfig/selinux 
sed -i "s/SELINUX=enforcing/SELINUX=disabled/" /etc/selinux/config

echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf
chkconfig iptables --level 2345 off

####################
#  Instal EPEL
####################
os567=`rpm -q centos-release | awk -F '-' '{print $3}'`
if [ $os567 -eq 5 ];then
	echo 'OS: CentOS 5'
	rpm -Uvh http://dl.fedoraproject.org/pub/epel/5/i386/epel-release-5-4.noarch.rpm  
elif [ $os567 -eq 6 ];then
	echo 'OS: CentOS 6'
	rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm 
elif [ $os567 -eq 7 ];then 
	echo 'OS: CentOS 7'
	rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-1.noarch.rpm
fi
 

####################
# TNP TIME SYNC
####################
isntp=`ps aux|grep ntpd |grep -v  'grep' |wc -l`
if [ $isntp -eq 1 ];
then
        echo 'NTP Installation over!!'
else
        echo 'NTP not Installed,Installing now ...'
        yum -y install ntpdate
        /usr/sbin/ntpdate asia.pool.ntp.org
        hwclock --systohc
        echo  '1 4 * * * /usr/sbin/ntpdate asia.pool.ntp.org 2>&1' >> /var/spool/cron/root
fi

yum -y update
shutdown -r now
      
####################
# Security
####################
	# 1.District root remote login
sed -i "s/#PermitRootLogin yes/PermitRootLogin no/" /etc/ssh/sshd_config
useradd exuxu
echo 'password.(*()' > pswd_celebi.txt
passwd celebi --stdin < pswd_celebi.txt
/etc/init.d/sshd start
	# 2.Deny of Host
yum -y install wget python
wget http://sourceforge.net/projects/denyhosts/files/denyhosts/2.6/DenyHosts-2.6.tar.gz
tar zxvf DenyHosts-2.6.tar.gz
cd DenyHosts-2.6
python setup.py install
cd /usr/share/denyhosts/
cp denyhosts.cfg-dist denyhosts.cfg
cp daemon-control-dist daemon-control
./daemon-control start
ln -s /usr/share/denyhosts/daemon-control /etc/init.d/denyhosts
echo "sshd: 110.86.xx.xx" >> /etc/hosts.allow
chkconfig --add denyhosts
chkconfig --level 2345 denyhosts on
	# 3.Fail2ban
	
	# 4.Iptables
	
	# 5.history
echo 'export HISTTIMEFORMAT="%F %T `whoami` "' >> /etc/profile
source /etc/profile
	
####################
 Enviroment 
####################
yum -y install make cmake lrzsz unzip zip  lsof vim nc wget curl telnet nmap traceroute man ntpd mlocate dos2unix  mailx

	python perl perl-DBI perl curl-devel  net-snmp net-snmp-devel openssh-clients gcc gcc-c++  
	httpd  
	mysql mysql-server mysql-devel   
	php php-mysql php-gd libjpeg* php-imap php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-mcrypt php-bcmath php-mhash libmcrypt php-gd php-xml php-bcmath php-xmlrpc php-mbstring php-mcrypt php-bcmath php-mhash   php-fpm libmcrypt-devel php-devel

####### samba? Ngnix? apache? mysql? ldap?
	      ++++++++++++++++++++++++++++++++
	      Config

	      ++++++++++++++++++++++++++++++++

	      sed -i "s/^DocumentRoot.*$/DocumentRoot '\/data\/www'/"  /etc/httpd/conf/httpd.conf
	      echo 'ServerName localhost:80' >> /etc/httpd/conf/httpd.conf
	      service httpd start

	      sed -i 's/^datadir.*$/datadir=\/data\/mysql/' /etc/my.cnf
	      service mysqld start
