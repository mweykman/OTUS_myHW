Part 1.
для настройки требуется запустить playbook1 с переменной -e tuntap=tun или -e tuntap=tun или =tap
ansible-playbook playbook1.yml -e tuntap=tun
в зависимости от значения переменной будет сконфигурирован и поднят ВПН туннель в режиме tun или tap
Part 2.
1) задать корректную локальную сеть в скрипте templates/certs_key_gen.sh. По умолчанию задана сеть в которой находится ВМ client
2) запусить playbook2
ansible-playbook playbook2.yml
3) подключиться к клиенту vagrant ssh client и перейти в папку /etc/openvpn, где должен быть конфиг и папка с сертификатами и ключем
cd /etc/openvpn
4) подключиться к VPN
sudo openvpn --config client.conf

при успешном подключении должен проходить пинг до сервера (для этого придется подключиться к клиенту из другого терминала параллельно):
ping 10.10.10.1