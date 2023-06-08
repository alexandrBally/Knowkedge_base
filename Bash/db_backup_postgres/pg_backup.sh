#!/bin/bash

DB_NAME=books
DB_HOST=dev-ops-elef.coieu8fnlstp.us-west-2.rds.amazonaws.com
DB_PORT=5432
DB_USER=abale
DB_PASS=fusionfusion
 
# Настройки бэкапа
BACKUP_DIR=/home/ubuntu/bash-backup/db_backup
DATE=$(date +%d-%m-%Y_%H-%M-%S)
BACKUP_FILE=$BACKUP_DIR/$DB_NAME-$DATE.dump
 
# Создание директории для бэкапа, если она не существует
if [ ! -d $BACKUP_DIR ]; then
  mkdir -p $BACKUP_DIR
fi
 
# Создание бэкапа базы данных
pg_dump --format=custom --dbname=postgresql://$DB_USER:$DB_PASS@$DB_HOST:$DB_PORT/$DB_NAME --file=$BACKU>
 
# Удаление старых бэкапов (оставляем только последние 7 дней)
find $BACKUP_DIR -name "$DB_NAME-*.dump" -mtime +7 -delete

# Вывод всех сообщений в лог-файл
END_TIME="$(date +%s)"

{
  echo "$SCRIPT_NAME$DATE — начало выполнения"
  echo "[$SCRIPT_NAME] Настройки базы данных:"
  echo "[$SCRIPT_NAME] DB_NAME = $DB_NAME, DB_HOST = $DB_HOST, DB_PORT = $DB_PORT, DB_USER = $DB_USER, D>
  echo "[$SCRIPT_NAME] BACKUP_DIR = $BACKUP_DIR, DATE = $DATE, BACKUP_FILE = $BACKUP_FILE"
  echo "[$SCRIPT_NAME] Создание директории для бэкапа, если она не существует"
  echo "[$SCRIPT_NAME] Создание бэкапа базы данных"
} | sudo tee -a /var/log/backup/backup.log

pg_dump --format=custom --dbname=postgresql://$DB_USER:$DB_PASS@$DB_HOST:$DB_PORT/"$DB_NAME" --file="$BA>

{
  echo "[$SCRIPT_NAME] Удаление старых бэкапов (оставляем только последние 7 дней)"
  echo "[$SCRIPT_NAME][$((END_TIME - START_TIME))s] — завершение выполнения"
} | sudo tee -a /var/log/backup/backup.log

