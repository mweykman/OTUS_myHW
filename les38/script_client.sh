#!/bin/bash
echo "инициализируем репозиторий borg на сервере backup"
# С шифрованием, запросит пароль
#borg init --encryption=repokey borg@192.168.56.10:/var/backup/
# Без ширования, не запрашивает пароль
borg init -e none borg@192.168.56.10:/var/backup/
echo "запускаем подготовленный ранее ancible'ом сервис для автоатического создания бэкапов"
sudo systemctl enable borg-backup.timer
sudo systemctl start borg-backup.timer