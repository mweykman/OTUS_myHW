Что нужно сделать?
Варианты стенда:

    nginx + php-fpm (laravel/wordpress) + python (flask/django) + js(react/angular);
    nginx + java (tomcat/jetty/netty) + go + ruby;
    можно свои комбинации.
    Реализации на выбор:
    на хостовой системе через конфиги в /etc;
    деплой через docker-compose.

Задание выполнено согласно методички: nginx + php-fpm (wordpress) + python (django) + js(node.js) с деплоем через docker-compose
Настройка окружения в docker-compose.
Разворачивание стенда происхоит автоматически сразу после запуска ВМ:
vagrant up
Результаты проверить по ссылкам:
http://localhost:8081/ 
http://localhost:8082/ 
http://localhost:8083/
Где при успешном выполнении задания будут отображены сайты django, js node, wordpress