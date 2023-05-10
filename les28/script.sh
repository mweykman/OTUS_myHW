#!/bin/bash
useradd otusadm && useradd otus
echo "Otus2022!" | passwd --stdin otusadm && echo "Otus2022!" | passwd --stdin otus
groupadd -f admin
usermod otusadm -aG admin && usermod root -aG admin && usermod vagrant -aG admin
LC_TIME=en_US.UTF-8
cd /vagrant
#cp -f sshd /etc/pam.d
echo "auth required pam_exec.so /usr/local/bin/login.sh" >> /etc/pam.d/sshd
cp -f login.sh /usr/local/bin
sudo date 082712302022.00