#!/bin/bash

DISK_LIMIT=30
DISK_USAGE=$(df -H / | awk '{ print $5 }' | tail -n 1 | cut -d'%' -f1)

if [ "$DISK_USAGE" -ge "$DISK_LIMIT" ]; then
    # Отправляем электронное письмо на почту
    echo "Диск заполнен на $DISK_USAGE%" 
fi