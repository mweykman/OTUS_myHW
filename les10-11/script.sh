#! /bin/bash
lockfile=/tmp/.mylockfile
if ( set -o noclobber; echo "$$" > "$lockfile") 2> /dev/null
then
LC_TIME=en_US.UTF-8
lastrun=$(cat /tmp/.my_script_lastrun)
###
cat << EOF > report.txt
REPORT

1. The number of requests to the site and source IP addresses. First 10
    count   IP
EOF
cut -d ' ' -f1 "access-4560-644067.log" | sort | uniq -c | sort -nr | head -n 10 >> report.txt
#или через awk
#awk '{print $1}' access-4560-644067.log | sort | uniq -c | sort -nr | head -n 10 >> report.txt
###
cat << EOF >> report.txt

2. Sites were requested. First 10
    count   site
EOF
cat access-4560-644067.log | grep "GET" | awk '{print $11}' | grep http | sort | uniq -c | sort -nr | head -n 10 >> report.txt
###
cat << EOF >> report.txt

3. Web server errors
Error log analysis should be here...

EOF
# error log should be here...
###
cat << EOF >> report.txt

4.  Code reqests
    count   code
EOF
awk '{print $9}' access-4560-644067.log | sort | uniq -c | sort -nr >> report.txt
###
date "+%s" > /tmp/.my_script_lastrun
sleep 20
rm /tmp/.mylockfile
else
echo "Failed to acquire lockfile: $lockfile."
echo "Held by $(cat $lockfile)"
fi