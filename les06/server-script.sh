#!/bin/bash
cd /vagrant && touch history.log
sudo -i
yum install -y nfs-utils
systemctl enable firewalld --now #в чём отличие enable and start
systemctl status firewalld | tee -a history.log
firewall-cmd --add-service="nfs3" \
--add-service="rpc-bind" \
--add-service="mountd" \
--permanent
firewall-cmd --reload
systemctl enable nfs --now
echo "check nfs service" | tee -a history.log
systemctl status nfs | tee -a history.log
ss -tnplu | grep 2049 | tee -a history.log
ss -tnplu | grep 20048 | tee -a history.log
mkdir -p /srv/share/upload
chown -R nfsnobody:nfsnobody /srv/share
chmod 0777 /srv/share/upload
cat << EOF > /etc/exports
/srv/share 192.168.50.11/32(rw,sync,root_squash)
EOF
exportfs -r
echo "check file /etc/exported" | tee -a history.log
exportfs -s | tee -a history.log
touch /srv/share/upload/uploadedfile.txt
touch /srv/share/file_from_server.txt
echo "Created files in share. ll /srv/share and ll /srv/share/upload" | tee -a history.log 
ls -la /srv/share | tee -a history.log
ls -la /srv/share/upload | tee -a history.log