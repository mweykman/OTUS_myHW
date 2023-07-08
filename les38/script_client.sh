#!/bin/bash
echo "инициализируем репозиторий borg на сервере backup"
borg init --encryption=repokey borg@192.168.56.10:/var/backup/
echo "запускаем подготовленный ранее ancible'ом сервис для автоатического создания бэкапов"
sudo systemctl enable borg-backup.timer
sudo systemctl start borg-backup.timer