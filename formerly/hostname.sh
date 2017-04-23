#!/bin/bash
#OS: CentOS 6.x

1.网络名(永久改动)           主机名称与网络活动相关
# vi /etc/sysconfig/network
NETWORKING=yes
HOSTNAME=yourname //在这修改hostname


2.域名表
＃ vi /etc/hosts
127.0.0.1 localhost.localdomain localhost 【网络IP地址；；主机名或域名；；主机名别名】
127.0.0.1 yourname //在这修改hostname


3.临时名
＃hostname yourname    //yourname为修改的hostname

4.网卡设定文件
/etc/sysconfig/network-scripts/ifcfg-*(eg:ifcfg-eth0)

5.重启网络
/etc/init.d/network restart
网关就会生效

及时显示改后的主机名需要logout && login，不过主机名一般不会影响你的网络应用的。

6.check
查看主机名命令
# uname -n
