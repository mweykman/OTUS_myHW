#!/bin/bash
cd /vagrant && touch history.log
sudo -i
lsblk >> history.log
pvcreate /dev/sdb
vgcreate vg_root /dev/sdb
lvcreate -n lv_root -l 100%FREE /dev/vg_root
mkfs.xfs /dev/vg_root/lv_root
mkdir /mnt/root
mount /dev/vg_root/lv_root /mnt/root
xfsdump -J - /dev/VolGroup00/LogVol00 | xfsrestore -J - /mnt/root
sleep 5
for i in /proc/ /sys/ /dev/ /run/ /boot/; do mount --bind $i /mnt/root/$i; done #разобрать этот алгоритм
sleep 5
chroot /mnt/root/
grub2-mkconfig -o /boot/grub2/grub.cfg
cd /boot ; for i in `ls initramfs-*img`; do dracut -v $i `echo $i|sed "s/initramfs-//g; s/.img//g"` --force; done #разобрать этот алгоритм
sed -i 's|\brd.lvm.lv=VolGroup00/LogVol00\b|rd.lvm.lv=vg_root/lv_root|g' /boot/grub2/grub.cfg
lsblk