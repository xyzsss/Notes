#!/bin/bash
#iftop
#
#monitor network traffic
#about flow,Reverse resolve,display port information ...
#time:2014.12.16
#

yum -y install libpcap libpcap-devel ncurses ncurses-devel
wget http://pkgs.fedoraproject.org/repo/pkgs/iftop/iftop-0.17.tar.gz/062bc8fb3856580319857326e0b8752d/iftop-0.17.tar.gz
tar -zxvf iftop-0.17.tar.gz
cd iftop-0.17
./configure
make
make install
cd ..
rm -rf iftop-0.17/  iftop-0.17.tar.gz
iftop
#iftop -i eth0
