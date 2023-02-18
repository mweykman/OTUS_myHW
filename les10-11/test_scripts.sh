#! /bin/bash
LC_TIME=en_US.UTF-8
date "+%s" > /tmp/.my_script_lastrun
lastrun=$(cat /tmp/.my_script_lastrun)
echo $lastrun
date +"%d/%b/%Y:%H:%M:%S" -d@$lastrun