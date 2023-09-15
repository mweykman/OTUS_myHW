#!/bin/bash
#to do on manager (Server1)
# sudo usermod -aG docker vagrant
docker swarm init --advertise-addr 192.168.56.10
touch token.sh
cat << EOF > token.sh
#!/bin/bash
EOF
docker swarm join-token worker | grep docker | tee -a token
chmod +x token.sh
#далее скопировать файл на сервера воркеры и запустить его там

#to add TAGs
docker node update --label-add TAG=wp Server1
docker node update --label-add TAG=wp Server2
docker node update --label-add TAG=grafana Server3