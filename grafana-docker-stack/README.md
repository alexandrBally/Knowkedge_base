Запуск мониторинга на основе Grafana, Prometheus

1. Склонировать репозиторий
2. выполнить команду, для создания docker stack
    - docker swarm init
3. docker stack deploy -c /home/alexelef/Desktop/grafana-docker-stack/docker-compose.yml dev-ops-elef-monitoring
4. Войти в http://127.0.0.1:3000
5. Configuration > data sourses > Prometheus > добавить адрес http://prometheus:9090
6. Импортировать дашборд графаны:
 - google > grafana dashboard node exporter > https://grafana.com/grafana/dashboards/1860-node-exporter-full/ 
 - Download JSON 
 - скопировать содержимое > Grafana > Dashboards > menage > import > past > Prometheus > import
7. Добавить в конфиг нод экспортер /var/lib/docker/volumes/monitoring_prom-configs/_data

28     static_configs:
29     - targets: ["localhost:9090"]
30
31   - job_name: "node-exporter"
32
33     static_configs:
34     - targets: ["node-exporter:9100"]

8. зайти в промисиус http://127.0.0.1:9090/ > status > targets > node-exporter (если его нет, то перезагрузить промисиус)
9.Перезагрузить дашборд 
10. Можно добавить другие сервера в конфиг и установить node-exporter на сервер


Вы можете просмотреть логи в формате Promethues, выполните следующие действия:

Установите promtool через команду brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/4e12509c6070dc703762fa604cc1e3fc994d8da7/Formula/prometheus.rb, если вы используете MacOS или используйте соответствующий инструмент для своей операционной системы.

Затем используйте команду promtool для проверки локальных логов:

promtool check log <log_file_name>
Где <log_file_name> - это имя файла журнала, который вы хотите проверить.

Вы также можете настроить Prometheus для сбора логов. Для этого установите Prometheus и добавьте конфигурацию для сбора логов.
global:
  scrape_interval:     15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'logs'
    file_sd_configs:
    - files:
      - /path/to/log/files/*.log
    relabel_configs:
    - source_labels: ['__meta_file_mtime']
      action: 'keep'
      regex: '.*'
      target_label: 'time'
      replacement: '$1'
    - source_labels: ['__meta_file_path']
      action: 'replace'
      target_label: '__path__'
      regex: '.*\/(.*)\.log'
      replacement: '${1}'
где /path/to/log/files/*.log - это путь к каталогу, содержащему журналы, которые вы хотите собрать, и __path__ - это метка цели, используемая для идентификации цели сбора логов.

После того, как вы настроили Prometheus для сбора логов, вы можете просмотреть их в Prometheus UI или воспользоваться PromQL для составления запросов и анализа собранных метрик.
