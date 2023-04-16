#!/bin/bash
# Author- naveenvk88@gmail.com
#Date-05-05-2017

DATELOG=$(date +'%d-%b-%y')
echo "Host Name=NTP Value" >> /root/Automation/NTP_REPORT/NTP_$DATELOG.csv 2>&1
for i in `cat /root/Automation/SERVER_INVENTORY_MASTER/server`
do
ssh $i 'bash -s' < /root/Automation/NTP_REPORT/ntp_output.sh  >>  /root/Automation/NTP_REPORT/NTP_$DATELOG.csv 2>&1
done
echo "HI , Please find the `date +%B` NTP report " | mutt -a "/root/Automation/NTP_REPORT/NTP_$DATELOG.csv" -s "NTP Report" -- naveenvk88@gmail.com


#######  cat /root/Automation/NTP_REPORT/ntp_output.sh
#!/bin/bash
# Author- naveenvk88@gmail.com
#Date-05-05-2017

echo -n `uname -n`;/usr/sbin/ntpq -pn|grep '*'|awk '{print "=" "*" $10}' |sed -e 's/*/ /g'
