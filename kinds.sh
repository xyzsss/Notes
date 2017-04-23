

last
#lastb
#lastlog
last log
who
w
# connect time log
# /var/log/wtmp  ,  /var/run/utmp, /var/log/messages (process log)
# /var/log/maillog (service log)

# 2  user
less /etc/passwd
grep :0 /etc/passwd
ls -l /etc/passwd  #check last modify time
awk -F: '$3==0 {print $1}' /etc/passwd 	#show userid eq 0
awk -F: 'length($2)==0 {print $1}' /etc/shadow	#check is exists of empty passwords for user
 
# 3 process
ps -aux
lsof -p pid	#show detail of process about port and files

# check hidden process
ps -ef| awk '{print }' | sort -n | uniq > 1
ls /proc | sort -n | uniq > 2
diff 1 2

# check file
find / -uid 0 -print 	#show super privileges users
find / -size + 10000k -print 	#show file size bigger than 10000k
find / -name "..." -print 	#show file named "..."
find / -name core -exec ls -l {} \;	#show files of user "core" then list them out
md5sum -b filename 	#show the md5 value of file
npm -qf /bin/ls		#check integrated of file 

# check network
ip link | grep PROMISC	#the netcard should not exists 'promisc' status,or be sniffered
lsof -i 
netstat -nap 	#show unusual port
arp -a		#show record of arp 

# check cron
crontab -u root -l
cat /etc/crontab
ls -l /etc/cron.*
ls /var/spool/cron



