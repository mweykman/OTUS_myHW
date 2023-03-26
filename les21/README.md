# -*- mode: ruby -*- 
less21. Prometheus
Для разворачивания Prometheus + Grafana используем docker stack. Использован ресурс: 
https://github.com/digitalstudium/grafana-docker-stack
Последовательность действий после клонирования:
1. Поднимаем контейнеры командой из папки с docker-compose.yml файлом:
docker compose up -d
2. Редактируем файл /var/lib/docker/volumes/monitoring_prom-configs/_data/prometheus.yml
Добавляем в концен файла следующие строки:
  - job_name: 'node-exporter'

    static_configs:
      - targets: ['node-exporter:9100']
3. для применения настроек перечитываем конфиг прометеуса:
docker ps | grep prometheus | awk '{print $1}' | xargs docker kill -s SIGHUP
4. В браузере заходим в графану http://hostIP:3000 где hostIP = IP хоста, на котором развернуты докер контейнеры.
Здесь после авторизации (admin/admin) меняем пароль и задаем в datasource (настройки - datasource - add datasource) url http://prometheus:9090
И импортируем dashboard ("+" - import) указав ID 1860 (полная ссылка на дашборд https://grafana.com/grafana/dashboards/1860). При импорте в графе prometheus выбрать prometheus.

Мой результат представлен в скрине mygrafana.jpg