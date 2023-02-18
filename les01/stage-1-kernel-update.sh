#!/bin/bash

mkdir Home-Work
cd Home-Work
echo "Kernel before upgrade" >> task-progress.txt
uname -a >> task-progress.txt
sudo yum install -y https://www.elrepo.org/elrepo-release-8.el8.elrepo.noarch.rpm 
sudo yum --enablerepo elrepo-kernel install kernel-ml -y
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
sudo grub2-set-default 0
echo "Kernel was downloaded. Grub update done." >> task-progress.txt
echo "Actual kernel version:" >> task-progress.txt
