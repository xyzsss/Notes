#!/bin/bash
# filename : install_zabbix_agent_RHEL.sh
# install zabbix agent on local environment

# --- global configration ---
ZABBIX_SERVER_ADDR=""
USER='root'
# --- end of configration ---

check_server_conf(){
	while [ "${ZABBIX_SERVER_ADDR}" == "" ];do
		echo -e "Input ZABBIX_SERVER_ADDR value:\c"
		read ZABBIX_SERVER_ADDR
			if [[ "${ZABBIX_SERVER_ADDR}" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]];then
					:
			else
					ZABBIX_SERVER_ADDR=""
			fi
	done
}
check_user(){
	if [ $USER == "${USER}" ];then
		echo 'User as root,OK!'
	else
		echo 'BAD USER,QUIT NOW.'
		exit 1
	fi
}
install_agent(){
    yum install zabbix-agent -y
    sed -i "s/^Server=127.0.0.1/Server=${ZABBIX_SERVER_ADDR}/g" /etc/zabbix/zabbix_agentd.conf
    sed -i 's/^ServerActive=127.0.0.1/ServerActive=/g' /etc/zabbix/zabbix_agentd.conf
}

# check os verion
check_server_conf
check_user
IS_OS7=`rpm --query centos-release|grep "release-7"|wc -l`
IS_OS6=`rpm --query centos-release|grep "release-6"|wc -l`
if [ $IS_OS7 -eq 1 ];then
    echo 'OS version is 7.'
    rpm -ivh http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm
    install_agent
    systemctl start zabbix-agent
    systemctl enable zabbix-agent
    firewall-cmd --add-port=10050/tcp        
    firewall-cmd --add-port=10050/tcp --permanent
    echo "Zabbix agent status: " `systemctl is-active zabbix-agent`
elif [ "$IS_OS6" -eq 1 ];then
    echo 'OS version is 6.'
    rpm -ivh http://repo.zabbix.com/zabbix/3.2/rhel/6/x86_64/zabbix-release-3.2-1.el6.noarch.rpm
    install_agent
    service  zabbix-agent start
    chkconfig zabbix-agent on
	iptables -I INPUT -p tcp -m tcp --dport 10050 -j ACCEPT
    echo "Zabbix agent status: " `service  zabbix-agent status`
else
    echo "OS not recognised!"
    cat /etc/redhat-release
fi
echo 'SELinux status: '`getenforce`
