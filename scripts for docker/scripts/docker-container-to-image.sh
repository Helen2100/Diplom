#!/bin/bash

docker ps -a
read -p "Введите название контейнера, из которого нужно получить образ: " name_work_container
read -p "Введите название создаваемого образа: " new_name_work_container
read -p "Введите тег для образа $new_name_work_container: " new_name_work_container_tag

if [[ $new_name_work_container_tag == "" ]]; then
    new_name_work_container_tag="latest"
fi

var1="$new_name_work_container"
var2="${var1}:"
name_image="$var2$new_name_work_container_tag"

docker stop $name_work_container
docker commit $name_work_container $name_image
