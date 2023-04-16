#!/bin/bash

Log=/home/naveen/uptime_report
DATELOG=$(date +'%d-%b-%y')
TimeLog=$(date +'%H-%M')
LOG_S=$Log/logs/error.log_$DATELOG
:>$LOG_S
/bin/echo "*********************************************" >> $LOG_S 2>&1
/bin/echo "========= Job Started ===========" >> $LOG_S  2>&1


echo "Host Name =OS =UP TIME =Down Time" >>  `pwd`/uptime_$DATELOG.csv 2>&1
for i in `cat Atlanta_servers Brain_servers Centre_servers slough_servers Bulle_servers`
do
UPTIME=`ssh $i /usr/bin/uptime | awk '{print $3}'`
OS_Version=`ssh $i head -1 /etc/issue`
ssh $i "uname -n | tr -d '\n''\t'; echo "=" | tr -d '\n';head -1 /etc/issue | tr -d '\n';echo "="|tr -d '\n';echo $UPTIME " >> `pwd`/uptime_$DATELOG.csv 2>&1
done

echo "HI , Please find the `date +%B` Uptime report " | mutt -a "/home/naveen/uptime_report/uptime_$DATELOG.csv" -s "Uptime Report" -- naveenvk88@gmail.com

/bin/echo "========= Job Completed ===========" >> $LOG_S  2>&1
/bin/echo "*********************************************" >> $LOG_S 2>&1
