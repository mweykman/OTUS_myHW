#!/bin/bash
useradd otusadm && useradd otus
echo "Otus2022!" | passwd --stdin otusadm && echo "Otus2022!" | passwd --stdin otus
groupadd -f admin
usermod otusadm -aG admin && usermod root -aG admin && usermod vagrant -aG admin
LC_TIME=en_US.UTF-8