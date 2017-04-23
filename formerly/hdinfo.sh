#!/bin/bash
#print hardware info
#Filename: hdinfo.sh
 

os_kernel=`uname -a`
os_info=`cat /etc/issue|grep -v 'an'|grep -v '^$'`
cpu_corenum=`cat /proc/cpuinfo |grep "cores"|uniq `
cpu_model=`cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq -c`
cpu_number=`cat /proc/cpuinfo | grep physical | uniq -c`
cpu_phynum=`cat /proc/cpuinfo |grep "processor"|wc -l` 
cpu_lognum=`cat /proc/cpuinfo |grep "physical id"|sort |uniq|wc -l`
is64_enable=`cat /proc/cpuinfo | grep flags | grep ' lm ' | wc -l`
is_HT=`cat /proc/cpuinfo | grep -e "cpu cores"  -e "siblings" | sort | uniq |sed 's/^/\t\t/g'`
##if result bigger than zero,then support.
cpu_moreinfo=`lscpu`
cpu_moreinfo2=`cat /proc/cpuinfo`

echo -e "\tTitle\t\tValue\n\tOS Kernel:\t$os_kernel\n\tOS Info:\t$os_info\n\tCPU CoreNum:\t$cpu_corenum\n\tCpu LogNum:\t$cpu_lognum\n\tCpu PhyNum:\
t$cpu_phynum\n\t(cpu Physical number  is cpu_corenum multiplied by cpu logical number)\n\tIs HT?(if output not equal,then yes.)\n$is_HT"
