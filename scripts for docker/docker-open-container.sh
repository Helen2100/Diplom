#!/bin/bash

docker ps -a

read -p "ID или название контейнера, в который нужно зайти: " name_container
echo "имя docker контейнера: " $name_container

sudo xhost +local:docker

docker start $name_container

docker exec -it -e DISPLAY=unix$DISPLAY $name_container /bin/bash
