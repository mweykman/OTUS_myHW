#!/bin/bash
yum install nano -y #just for more comfortable to check and fix anything
# Part 1
cd /vagrant
cp watchlog /etc/sysconfig/
cp watchlog.sh /opt
cp watchlog.service /etc/systemd/system
cp watchlog.timer /etc/systemd/system
cat << EOF > /var/log/watchlog.log
random text here
here
and ALERT some here
EOF
systemctl start watchlog.timer
#systemctl status watchlog.timer
systemctl start watchlog.service
#systemctl status watchlog.service
echo "check LOGs with command tail -f /var/log/messages"
#### Part 2
yum install epel-release -y && yum install spawn-fcgi php php-cli mod_fcgid httpd -y
cp spawn-fcgi.service /etc/systemd/system
sed -i '7,8 s/#/ /' /etc/sysconfig/spawn-fcgi #uncomment 7 and 8 lines
systemctl start spawn-fcgi
echo "check service with command systemctl status spawn-fcgi"
#### Part 3
cp /usr/lib/systemd/system/httpd.service /etc/systemd/system/httpd@.service
sed -i '/^EnvironmentFile/ s/$/-%I/' /etc/systemd/system/httpd@.service
echo "OPTIONS=-f conf/first.conf" > /etc/sysconfig/httpd-first
echo "OPTIONS=-f conf/second.conf"> /etc/sysconfig/httpd-second
cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/first.conf
cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/second.conf
sed -i 's/Listen 80/Listen 8088/' /etc/httpd/conf/first.conf
sed -i 's/Listen 80/Listen 8089/' /etc/httpd/conf/second.conf
sed -i '/ServerRoot "\/etc\/httpd"/a PidFile \/var\/run\/httpd-first.pid' /etc/httpd/conf/first.conf
sed -i '/ServerRoot "\/etc\/httpd"/a PidFile \/var\/run\/httpd-second.pid' /etc/httpd/conf/second.conf
systemctl start httpd@first
systemctl start httpd@second
echo "check ports with command ss -tnulp"