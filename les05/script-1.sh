#!/bin/bash
cd /vagrant
touch history.log
sudo -i
#task 1
zpool create otus1 mirror /dev/sdb /dev/sdc
zpool create otus2 mirror /dev/sdd /dev/sde
zpool create otus2 mirror /dev/sdf /dev/sdg
zpool create otus3 mirror /dev/sdf /dev/sdg
zpool create otus4 mirror /dev/sdh /dev/sdi
zpool list
zpool status
zfs set compression=lzjb otus1
zfs set compression=lz4 otus2
zfs set compression=gzip-9 otus3
zfs set compression=zle otus4
zfs get all | grep compression
#for i in {1..4}; do wget -P /otus$i https://gutenberg.org/cache/epub/2600/pg2600.converter.log; done #так 4 раза загружаться из Интернета файл будет
wget -P /otus1 https://gutenberg.org/cache/epub/2600/pg2600.converter.log #а так всего 1 раз и далее копируем его в разные разделы
cp /otus1/* /otus2
cp /otus1/* /otus3
cp /otus1/* /otus4
echo 'Task 1. Find the best compression' >> /vagrant/history.log
zfs get all | grep compressratio | grep -v ref >> /vagrant/history.log
#task 2
wget -O archive.tar.gz --no-check-certificate 'https://drive.google.com/u/0/uc?id=1KRBNW33QWqbvbVHa3hLJivOAt60yukkg&export=download'
tar -xzvf archive.tar.gz
zpool import -d zpoolexport/ otus
echo 'Task 2. Restore unknown ZFS FS from archive' >> /vagrant/history.log
zpool status otus >> /vagrant/history.log
echo 'and get some information from them' >> /vagrant/history.log
echo '1) FS size' >> /vagrant/history.log
zfs get available otus >> /vagrant/history.log
echo '2) Type of FS' >> /vagrant/history.log
zfs get readonly otus >> /vagrant/history.log
echo '3) Recordsize' >> /vagrant/history.log
zfs get recordsize otus >> /vagrant/history.log
echo '4) Compression' >> /vagrant/history.log
zfs get compression otus >> /vagrant/history.log
echo '5) Cheksum' >> /vagrant/history.log
zfs get checksum otus >> /vagrant/history.log
#task 3
wget -O otus_task2.file --no-check-certificate 'https://drive.google.com/u/0/uc?id=1gH8gCL9y7Nd5Ti3IRmplZPF1XjzxeRAG&export=download'
zfs receive otus/test@today < otus_task2.file
echo 'Task 3. Find secret link in secret message' >> /vagrant/history.log
cat $(find /otus/test -name "secret_message") >> /vagrant/history.log