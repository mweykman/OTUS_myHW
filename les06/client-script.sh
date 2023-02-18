#!/bin/bash
cd /vagrant && touch client-history.log
sudo -i
yum install -y nfs-utils
systemctl enable firewalld --now
systemctl status firewalld | tee -a client-history.log
echo "192.168.50.10:/srv/share/ /mnt nfs vers=3,proto=udp,noauto,x-systemd.automount 0 0" >> /etc/fstab
systemctl daemon-reload #перезапуск какиз демонов?
systemctl restart remote-fs.target
mount | grep mnt | tee -a client-history.log