#!/bin/bash
cd /vagrant #перейдем в папку со скриптом
echo "Nginx status after starting system" > progress.txt
systemctl status nginx.service | grep "Active" >> progress.txt
echo "---" >> progress.txt
echo "Reason of problem follow:" >> progress.txt
audit2why -i /var/log/audit/audit.log >> progress.txt #данный модуль, входящий в пакет policycoreutils-python выведит причину ошибки незапуска nginx
echo "---" >> progress.txt
echo "So first way to resolve problem is allowing nis: setsebool -P nis_enabled 1" >> progress.txt
#First way
setsebool -P nis_enabled 1 #включим параметр nis_enable переключателя setsebool
systemctl restart nginx.service #здесь и далее после применения решения перезапускаем сервис 
curl 127.0.0.1:4881 | grep "title" >> progress.txt #и проверяем curl'ом доступность сайта (при успехе в отчет попадет залоговок Welcome to CentOS)
#Second way
echo "---" >> progress.txt
echo "Second way: add unusual port to alowed list of ports for http" >> progress.txt
setsebool -P nis_enabled off #выключил переключатель обратно
semanage port -a -t http_port_t -p tcp 4881 #добавим порт tcp 4881 в группу разрешенных портом https_port_t
semanage port -l | grep http_port_t >> progress.txt
systemctl restart nginx.service
curl 127.0.0.1:4881 | grep "title" >> progress.txt
#Third way
semanage port -d -t http_port_t -p tcp 4881 #удалим данный порт снова
echo "---" >> progress.txt
echo "Third way: configure module SyLinux with allowed port" >> progress.txt
grep nginx /var/log/audit/audit.log | audit2allow -M nginx #здесь утилита audit2allow на основе логов создаст модуль, разрешающий работу nginx на нестандартном порту
semodule -i nginx.pp #включим данный модуль
echo "Nginx module turned on" >> progress.txt
semodule -l | grep "nginx" >> progress.txt
systemctl restart nginx.service
curl 127.0.0.1:4881 | grep "title" >> progress.txt
#напоследок выключим данный модуль и вернем nginx в нерабочее состоние если необходимо
semodule -r nginx