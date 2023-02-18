#!/bin/bash
sudo -i
mkdir HomeWork && cd HomeWork
echo "Preparing.. Let's check connected disks" > HW-progress.txt
lsblk >> HW-progress.txt
yum install -y mdadm smartmontools hdparm gdisk lvm2
mdadm --zero-superblock --force /dev/sd{b,c,d,e,f}
echo y | mdadm --create --verbose /dev/md0 -l 10 -n 4 /dev/sd{b,c,d,e}
mkfs.ext4 /dev/md0
mount /dev/mnt0 /mnt
echo "We've created RAID 10 and file system" >> HW-progress.txt
mdadm -D /dev/md0 >> HW-progress.txt
df -h >> HW-progress.txt
echo "But disk sdb was temporary solution and should be replaced. Let's do it" >> HW-progress.txt
mdadm /dev/md0 --fail /dev/sdb && mdadm /dev/md0 --remove /dev/sdb
cat /proc/mdstat >> HW-progress.txt
echo "New disk sdf is alredy online" >> HW-progress.txt
echo y | mdadm /dev/md0 --add /dev/sdf
sleep 3
echo "We've added it to RAID" >> HW-progress.txt
mdadm -D /dev/md0 >> HW-progress.txt
echo "but now we have all 4 disks by 150MB, so we can resize our RAID" >> HW-progress.txt
mdadm --grow --size=max /dev/md0
resize2fs /dev/md0
mdadm -D /dev/md0 | grep "Array Size" >> HW-progress.txt
echo "Now we will create mdadm config file" >> HW-progress.txt
mkdir /etc/mdadm
echo "DEVICE partitions" > /etc/mdadm/mdadm.conf
mdadm --detail --scan --verbose | awk '/ARRAY/{print}' >> /etc/mdadm/mdadm.conf
echo "It's done. Cat /etc/mdadm/mdadm.conf" >> HW-progress.txt
cat /etc/mdadm/mdadm.conf >> HW-progress.txt
echo "PART 2" >> HW-progress.txt
echo "Now we'll create 5 GPT partitions and mount them" >> HW-progress.txt
parted -s /dev/md0 mklabel gpt
parted -s /dev/md0 mkpart primary ext4  0% 20%
parted -s /dev/md0 mkpart primary ext4 20% 40%
parted -s /dev/md0 mkpart primary ext4 40% 60%
parted -s /dev/md0 mkpart primary ext4 60% 80%
parted -s /dev/md0 mkpart primary ext4 80% 100%
mkdir -p /raid/part{1..5}
for i in $(seq 1 5); do mkfs.ext4 /dev/md0p$i; done
for i in $(seq 1 5); do mount /dev/md0p$i /raid/part$i; done
echo "It's done, let's check result:" >> HW-progress.txt
df -h >> HW-progress.txt