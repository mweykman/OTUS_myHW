#! /bin/bash
#VAR
lockfile=/tmp/.mylockfile
logFile=./access-4560-644067.log
X=10 #how many active IP we will search
email=admin
LC_TIME=en_US.UTF-8 #if host hame RU time settings
if ( set -o noclobber; echo "$$" > "$lockfile") 2> /dev/null
    then
    ###
    echo "Start report" > report.txt
    echo  ------------- >> report.txt
    if [ -f lastrun.tmp ] #check: do we have file lastrun.tmp in our folder?
    then
        start_time=$(cat lastrun.tmp) #get previus report time
        start_line=$(cat $logFile | grep -n -m 1 $start_time | awk -F ':' '{print $1}')
        if [ -z "$start_line" ] #if start_line is empty
        then
            echo "WARNING: no entry point for log processing. Maybe log was rotated" >> report.txt
            start_line=0
        fi
    else #no lustrun.tmp file
        echo "### This is first run of script ###" >> report.txt
        start_line=0
        start_time=$(head -n 1 $logFile | awk '{print $4}' | tr -d '[')
    fi
    end_line=$(cat $logFile | wc -l)
    lines_for_processing=$(($end_line - $start_line))
    end_time=$(tail -n 1 $logFile | awk '{print $4}' | tr -d '[')
    echo $end_time > lastrun.tmp #save last time of script - it will be start time for next script running
    ###
    echo "..begin from $start_line line of $end_line" >> report.txt
    echo "..from $start_time to $end_time" >> report.txt
    echo "1. TOP $X of IPs:" >> report.txt
    tail_begin=$(($end_line - $start_line))
    tail -n $tail_begin $logFile | awk '{print $1}' | sort | uniq -c | sort -nr | head -n $X >> report.txt
    ###
    echo "2. TOP $X requested URLs:" >> report.txt
    tail -n $tail_begin $logFile | grep "GET" | awk '{print $11}' | grep http | sort | uniq -c | sort -nr | head -n $X >> report.txt
    ###
    echo "3. TOP $X error codes:" >> report.txt
    tail -n $tail_begin $logFile | awk '{if ($9 > 399 && $9 < 600) print $9}' | sort | uniq -c | sort -nr | head -n $X >> report.txt
    ###
    echo "4. All HTTP codes:" >> report.txt
    tail -n $tail_begin $logFile | awk '{print $9}' | sort | uniq -c | sort -nr >> report.txt
    echo ------------- >> report.txt
    ###
    cat report.txt | mail -s "Report from $start_time to $end_time" $email
    rm /tmp/.mylockfile
else
echo "Failed to acquire lockfile: $lockfile."
echo "Held by $(cat $lockfile)"
fi