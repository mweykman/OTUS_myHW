#!/bin/bash
## part 2
echo "проверим логи selinux"
cat /var/log/audit/audit.log | audit2why
echo "на ns01 видим ошибку в контексте безопасности: вместо типа named_t используется тип etc_t"
echo "проверим контексты файлов в каталоге /etc/named"
ls -Z /etc/named
echo "также видим, что контекст безопасности неправильный"
echo "!!! Проблема заключается в том, что конфигуационные файлы лежат в другом каталоге"
echo "Проверим, в каком каталоге должны лежать файлы, чтобы на них распространялись корректные политики selinux"
semanage fcontext -l | grep named
echo "изменим тип контекста безопасности для каталога /etc/named"
chcon -R -t named_zone_t /etc/named
echo "проверяем"
ls -Z /etc/named
echo "возвращаемся на ВИ client для поверки" 