#!/bin/bash

. ./info-account.sh

docker images
read -p "Введите название образа с тегом через двоеточие c локальной машины: " name_local_image

curl -u $USERNAME:$PASSWORD -k https://$REGISTRY_URL/v2/_catalog
read -p "Введите название образа с его репозиторием в Harbor: " name_repo_img

curl -u $USERNAME:$PASSWORD -k https://$REGISTRY_URL/v2/$name_repo_img/tags/list
read -p "Введите тег образа $name_repo_img из репозитория Harbor: " name_tag

var1="${REGISTRY_URL}/"
var2="$var1$name_repo_img"
var3="${var2}:"
name_repo_image="$var3$name_tag"

echo "Было введено:"
echo "1) имя базового докер образа: " $name_local_image
echo "2) имя docker образа из репозитория Harbor: " $name_repo_image

docker image inspect --format "{{.RepoDigests}}" $name_local_image > ./all-info.txt
line_1=$(cat ./all-info.txt)
digests=$(echo ${line_1#*@})
digests_local_image=${digests::-1}

curl -u $USERNAME:$PASSWORD -i -k https://$REGISTRY_URL/v2/$name_repo_img/manifests/$name_tag > ./all-info.txt
head -n7 ./all-info.txt > ./digests.txt 
line=$(grep 'Docker-Content-Digest: ' ./digests.txt)
digests_image=$(echo ${line#*Docker-Content-Digest: })
digests_repo_image=${digests_image::-1}

rm ./all-info.txt ./digests.txt

if [[ "$digests_repo_image" == "$digests_local_image" ]]; then
    echo "Образы совпадают. Контрольные суммы совпадают."
else
    echo "Образы не совпадают. Контрольные суммы не совпадают."
fi
