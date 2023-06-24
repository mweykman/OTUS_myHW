#!/bin/bash
#part 1
echo "Проверяем наличие проблемы - внесем изменение в зону ns"
#следующие 6 строк необходимо завернут в скрипт
#  nsupdate -k /etc/named.zonetransfer.key
#  server 192.168.50.10
#  zone ddns.lab
#  update add www.ddns.lab. 60 A 192.168.50.15
#  send
#  quit
echo "при попытке отправить изменения видем ошибку update failed: SERVFAIL"
echo "после исправления проблемы - ошибки не будет"
echo "проверим логи selinux"
cat /var/log/audit/audit.log | audit2why
echo "на client ошибки отсутствуют, повторяем скрипт на ns01. Подключаемся к ns01"

#part 3
echo "ошибок выше нет, проверяем запросом dig работу ns-сервера"
dig www.ddns.lab
echo "видим, что изменения теперь применяются"
echo "теперь можем перезапустить обе виртуалки и проверить еще раз запросом dig с клиентской ВМ"