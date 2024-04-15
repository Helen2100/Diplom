#18.03.2024

#!/bin/bash

answer="i"

while [[ "$answer" == "container" || "$answer" == "c" || "$answer" == "image" || "$answer" == "i" || "$answer" == "docker-cache" || "$answer" == "dc" ]];
do
    read -p "Что нужно удалить (container(c)/image(i)/docker-cache(dc)/quit(q)): " answer

    if [[ "$answer" == "docker-cache" || "$answer" == "dc" ]]; then
        docker builder prune
    fi

    if [[ "$answer" == "image" || "$answer" == "i" ]]; then
        docker images
        read -p "Введите название docker образа или его IMAGE ID: " name_work_image
        echo "Было введено:"
        echo "1) имя docker контейнера: " $name_work_image
        docker rmi $name_work_image
    fi

    if [[ "$answer" == "container" || "$answer" == "c" ]]; then
        docker ps -a
        read -p "Введите название docker контейнера или его CONTAINER ID: " name_work_container
        echo "Было введено:"
        echo "1) имя docker контейнера или CONTAINER ID: " $name_work_container
        docker stop $name_work_container
        docker rm $name_work_container
    fi
done
exit
