#!/bin/bash
sudo -i
cd /vagrant
lsblk >> history.log
lvremove /dev/vg_root/lv_root -y
vgremove /dev/vg_root -y
pvremove /dev/sdb -y
lsblk
#creating home on LVM
lvcreate -n LogVol_Home -L 2G /dev/VolGroup00
mkfs.xfs /dev/VolGroup00/LogVol_Home
mkdir /mnt/home
mount /dev/VolGroup00/LogVol_Home /mnt/home
cp -aR /home/* /mnt/home
rm -rf /home/*
umount /mnt/home
mount /dev/VolGroup00/LogVol_Home /home/
echo "`blkid | grep Home | awk '{print $2}'` /home xfs defaults 0 0" >> /etc/fstab
#working with snaps
touch /home/file{1..20}
lvcreate -L 100MB -s -n home_snap /dev/VolGroup00/LogVol_Home
dd if=/dev/zero of=/home/big-file.log bs=1M count=50
rm -f /home/file{11..20}
lsblk >> history.log
umount /home
lvconvert --merge /dev/VolGroup00/home_snap
mount /home
ls /home >> history.log
lsblk >> history.log