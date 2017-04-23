#!/bin/bash
EPEL,Extra package For Enterprise Linux



##EPEL    CentOS/REDHAT/Fedora 7/6/5 ##  
rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-1.noarch.rpm
rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm  
rpm -Uvh http://dl.fedoraproject.org/pub/epel/5/i386/epel-release-5-4.noarch.rpm  

##REMI    CentOS/REDHAT/Fedora 7/6/5 ##     http://rpms.famillecollet.com/
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-5.rpm
  
 
#RPMForge,Security,Stable            http://repoforge.org/
#RPMFusion,Fedora entertainment      http://rpmfusion.org/

