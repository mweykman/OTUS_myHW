АРХИТЕКТУРА СЕТИ

Задача настроить сеть согласно схеме из методички:
https://docs.google.com/document/d/1XtCmYJYPKwoMDjwiTskALvYLZaE4I49g/edit
Все узлы сети должны иметь доступ к Интернету и друг к другу.

Этап 1.
Инфраструктура поднимается с помощью vagrant, провайдер virtual box.
Запуск: vagrant up

Vagrantfile поднимет следующие хосты (все кроме двух серверов на CenOS7)
    inetRouter - роутер, выпускающий все виртуальные машины в Интернет
    centralRouter - роутер центрального офиса
    centralServer - сервер центрального офиса
    office01Router - роутер первого офиса
    office01Server - сервер первого офиса, Ubuntu 20.04
    office02Router - роутер второго офиса
    office02Server - сервер второго офиса, Ubuntu 20.04

 В целом архитектура выглядит так: 
    Сеть office01
    192.168.2.0/26 - dev
    192.168.2.64/26 - test servers
    192.168.2.128/26 - managers
    192.168.2.192/26 - office hardware
    Сеть office02
    192.168.1.0/25 - dev
    192.168.1.128/26 - test servers
    192.168.1.192/26 - office hardware
    Сеть central
    192.168.0.0/28 - directors
    192.168.0.32/28 - office hardware
    192.168.0.64/26 - wifi
    ```
    Office1 ---\
    ----> Central --IRouter --> internet
    Office2----/
    ```
Полная таблица сетевой структуры прописана здесь: https://docs.google.com/spreadsheets/d/19xLUJur0US4fDh69WzyeKImaInDHkWhrR9a-6MBQN9w/edit#gid=0
Этап 2. Настройка с помощью Ansible:
ansible-playbook -i hosts playbook.yml
данный playbook осуществляет всю настройку сети, а именно:
- настраивает Nat и iptable на роутере inetRouter
- удаляются маршруты по умолчанию, которые добавляет Vagrant (за исключением серверов на Убунту, где маршруты остаются активны, но с бОльшей метрикой)
- на всех роутерах настраивается forwarding
- добавляются прямые и обратные маршруты

Доделать:
- установить инструменты диагностики сети