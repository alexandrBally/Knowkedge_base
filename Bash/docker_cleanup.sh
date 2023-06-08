#!/bin/bash
DATE=$(date +%d-%m-%Y_%H-%M-%S)
SCRIPT_NAME=docker_cleanup.sh
CLEANUP_DIR=/home/ubuntu/bash-backup
CLEANUP_FILE=docker_cleanup.sh


DATE=$(date +%d-%m-%Y_%H-%M-%S)



echo "---------> Active container";
docker ps
echo "---------> Stopped containers";
docker ps -a

echo "---------> Start clearing my memory";
echo "---------> emoving redundant containers";
if echo "Y" | docker container prune; then
    echo "---------> Compleated";
else echo container deletion error;
fi

docker images;
echo "---------> Removing redundant images";
echo "Y" | docker system prune -f || echo images deletion error;
echo "---------> Сleaning completed";

{
  echo "$DATE $SCRIPT_NAME — начало выполнения"
echo "---------> Active container";
docker ps
echo "---------> Stopped containers";
docker ps -a
echo "---------> Start clearing my memory";
echo "---------> emoving redundant containers";
if echo "Y" | docker container prune; then
    echo "---------> Compleated";
else echo container deletion error;
fi
echo "-------------------------------------------------------------";
docker images;
echo "-------------------------------------------------------------";

echo "---------> Removing redundant images";
echo "Y" | docker system prune -f || echo images deletion error;
echo "---------> Сleaning completed";
} | tee -a /var/log/backup/docker_clouse.log


