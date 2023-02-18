#!/bin/bash
sudo -i
cd /vagrant
lsblk >> history.log
lvremove /dev/VolGroup00/LogVol00 -y
lvcreate -n VolGroup00/LogVol00 -L 8G /dev/VolGroup00 -y
mkfs.xfs /dev/VolGroup00/LogVol00
mount /dev/VolGroup00/LogVol00 /mnt/root
xfsdump -J - /dev/vg_root/lv_root | xfsrestore -J - /mnt/root
sleep 5
for i in /proc/ /sys/ /dev/ /run/ /boot/; do mount --bind $i /mnt/root/$i; done
chroot /mnt/
grub2-mkconfig -o /boot/grub2/grub.cfg
cd /boot ; for i in `ls initramfs-*img`; do dracut -v $i `echo $i|sed "s/initramfs-//g; s/.img//g"` --force; done
pvcreate /dev/sdc /dev/sdd
vgcreate vg_var /dev/sdc //dev/sdd
lvcreate -L 950M -m1 -n lv_var vg_var
mkfs.ext4 /dev/vg_var/lv_var
mkdir /mnt/var
mount /dev/vg_var/lv_var /mnt/var
cp -aR /var/* /mnt/var # rsync -avHPSAX /var/ /mnt/var #почитать про rsync
mkdir /tmp/oldvar && mv /var/* /tmp/oldvar
umount /mnt/var
mount /dev/vg_var/lv_var /var
echo "`blkid | grep var: | awk '{print $2}'` /var ext4 defaults 0 0" >> /etc/fstab
lsblk