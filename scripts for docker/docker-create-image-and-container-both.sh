#05.02.2024

#!/bin/bash

. ./info-account.sh

read -p "Скачать образ из репозитория Harbor (yes/no): " answer

if [[ "$answer" == "yes" || "$answer" == "y" ]]; then
    echo "Вывод репозиториев с проектами: "
    curl -u $USERNAME:$PASSWORD -k https://$REGISTRY_URL/v2/_catalog
    read -p "Введите название образа с его репозиторием в Harbor: " name_repo_img
    curl -u $USERNAME:$PASSWORD -k https://$REGISTRY_URL/v2/$name_repo_img/tags/list
    read -p "Введите тег образа $name_repo_img из репозитория Harbor: " name_tag
    read -p "Введите новое название docker образа c тегом через : (по умолч. тег = :latest): " name_work_image
    read -p "Введите новое название docker контейнера: " name_work_container
    find . -type f -name "Dockerfile*"
    echo "Dockerfile_create  -  создать образ с графическим интерфейсом"
    echo "Dockerfile_copy-file  -  создать образ с графическим интерфейсом и загрузить папки и файлы, которые лежат рядом с этим скриптом"
    read -p "Введите название Dockerfile: " DockerFile
    var1="${REGISTRY_URL}/"
    var2="$var1$name_repo_img"
    var3="${var2}:"
    name_base_image="$var3$name_tag"
    echo "Было введено:"
    echo "1) имя базового докер образа: " $name_base_image
    echo "2) имя docker образа: " $name_work_image
    echo "3) имя docker контейнера: " $name_work_container
    echo "4) имя Dockerfile: " $DockerFile

    docker login $REGISTRY_URL -u $USERNAME -p $PASSWORD
    docker pull $name_base_image

fi

if [[ "$answer" == "no" || "$answer" == "n" ]]; then
    docker images
    read -p "Введите название docker образа c тегом, который будет лежать в основе нового docker образа: " name_base_image
    read -p "Введите новое название docker образа c тегом (по умолч. тег = latest): " name_work_image
    read -p "Введите новое название docker контейнера: " name_work_container
    find . -type f -name "Dockerfile*"
    echo "Dockerfile_create  -  создать образ с графическим интерфейсом"
    echo "Dockerfile_copy-file  -  создать образ с графическим интерфейсом и загрузить папки и файлы, которые лежат рядом с этим скриптом"
    read -p "Введите название Dockerfile: " DockerFile
    echo "Было введено:"
    echo "1) имя docker образа: " $name_base_image
    echo "2) имя docker образа: " $name_work_image
    echo "3) имя docker контейнера: " $name_work_container
    echo "4) имя Dockerfile: " $DockerFile
fi

if [[ "$answer" != "no" && "$answer" != "n" && "$answer" != "yes" && "$answer" != "y" ]]; then
    exit
fi

sudo xhost +local:docker

docker build --tag $name_work_image --build-arg image=$name_base_image --file ./$DockerFile .
#docker buildx build --tag $name_work_image --file ./Dockerfile .
#docker build --tag $name_work_image --file ./Dockerfile .

docker run -it --name $name_work_container -e DISPLAY=unix$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --privileged $name_work_image /bin/bash

