#05.02.2024

#!/bin/bash

. ./info-account.sh

read -p "Загрузить в репозиторий контейнер (yes/no)? " answer

if [[ "$answer" == "yes" || "$answer" == "y" ]]; then
    echo "Вывод репозиториев с проектами: "
    curl -u $USERNAME:$PASSWORD -k https://$REGISTRY_URL/v2/_catalog
    read -p "Введите название репозитория в Harbor: " name_repo
    docker ps -a
    read -p "Введите название контейнера, загружаемого на Harbor: " name_work_container
    read -p "Введите новое название контейнера для Harbor: " new_name_work_container
    read -p "Введите тег для $new_name_work_container контейнера: " new_name_work_container_tag
    var1="${REGISTRY_URL}/"
    var2="$var1$name_repo"
    var3="${var2}/"
    var4="$var3$new_name_work_container"
    var5="${var4}:"
    name_push_image="$var5$new_name_work_container_tag"
    echo "Было введено:"
    echo "1) название контейнера, загружаемого на Harbor: " $name_work_container
    echo "2) новое название контейнера - с ip адрессом Harbor: " $name_push_image

    docker stop $name_work_container
    docker commit $name_work_container $name_push_image
fi

if [[ "$answer" == "no" || "$answer" == "n" ]]; then
    read -p "Загрузить в репозиторий образ (yes/no)? " answer

    if [[ "$answer" != "yes" && "$answer" != "y" ]]; then
        exit
    fi

    if [[ "$answer" == "yes" || "$answer" == "y" ]]; then
        echo "Вывод репозиториев с проектами: "
        curl -u $USERNAME:$PASSWORD -k https://$REGISTRY_URL/v2/_catalog
        read -p "Введите название репозитория в Harbor: " name_repo
        docker images
        read -p "Введите название образа, загружаемого на Harbor: " name_image

        read -p "Изменить название образа (yes/no)? " answer
        if [[ "$answer" == "yes" || "$answer" == "y" ]]; then
            read -p "Введите новое название образа для Harbor: " new_name_image
            read -p "Введите тег для $new_name_image образа: " new_name_image_tag
            var1="${REGISTRY_URL}/"
            var2="$var1$name_repo"
            var3="${var2}/"
            var4="$var3$new_name_image"
            var5="${var4}:"
            name_push_image="$var5$new_name_image_tag"
            docker tag $name_image $name_push_image
        fi

        if [[ "$answer" == "no" || "$answer" == "n" ]]; then
            name_push_image=$name_image
            echo "ok"
        fi

        if [[ "$answer" != "no" && "$answer" != "n" && "$answer" != "yes" && "$answer" != "y" ]]; then
            exit
        fi
    fi

    echo "Было введено:"
    echo "1) название образа, загружаемого на Harbor: " $name_image
    echo "2) новое название образа - с ip адрессом Harbor: " $name_push_image
fi

if [[ "$answer" != "no" && "$answer" != "n" && "$answer" != "yes" && "$answer" != "y" ]]; then
    exit
fi

docker login $REGISTRY_URL -u $USERNAME -p $PASSWORD

docker push $name_push_image
