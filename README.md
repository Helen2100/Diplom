# Диплом
Материалы по ВКР "Внедрение непрерывной интеграции программного обеспечения специального назначения на предприятии". 

Автор: Служеникина Елена Юрьевна 

Группа: РИ-400012

## Пример контейнера с поддержкой графического интерфейса приложения 
Задача:
	Создать Dockerfile для проекта, которому необходимы следующие компоненты: Debian:10, qtbase5-dev, libboost-all-dev, cmake и g++
Цель:
	Вывод графического интерфейса приложения на экран.
Трудности:
	В Docker нет поддержки графического интерфейса, поэтому нет возможности запускать графические приложения внутри контейнера.

### project_qt_1
Проект, в котором не прописана поддержка графического интерфейса приложения.
Для запуска загрузки образа из Dockerfile:
```
docker build -t <name-image> .
# docker run -it --name <name-container> <name-image>
```
### project_qt_2
Необходимо использовать xhost на хосте для отображения наших приложений с графическим интерфейсом. Команда для подключения docker к xhost ```sudo xhost +local:docker```.
```
sudo xhost +local:docker
docker build -t <name-image> .
docker run --name <name-container> -e DISPLAY=unix$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix <name-image>
```
### project_qt_3
Необходимо использовать xhost на хосте для отображения наших приложений с графическим интерфейсом. Команда для подключения docker к xhost ```sudo xhost +local:docker```.
Необходимо проверить uid и gid в Dockerfile с uid и gid в хост системе. Для этого необходимо в хост системе прописать команду ```id```.
```
id
sudo xhost +local:docker
docker buildx build --tag <name-image> --file ./Dockerfile .
docker run --rm -it --name <name-container> --env DISPLAY=$DISPLAY --privileged --volume /tmp/.X11-unix:/tmp/.X11-unix <name-image>
```
### Отличие project_qt_2 от project_qt_3
В project_qt_2 показана реализация подключения постоянной среды ```ENV QT_QPA_PLATFORM=xcb```.
В project_qt_3 показана реализация подключения пользователя хост машины к docker образу.

## Пример переноса сайта отдела в Docker контейнер.
Задача:
	Создать Dockerfile для проекта,  прописав в файле requirements.txt все зависимости. 

Для запуска загрузки образа из Dockerfile:
```
docker build -t <name-image> .
# docker run -it --name <name-container> <name-image>
```

## Пример переноса операционной системы с ее файлами из chroot системы в Docker image.
Задача:
	Перенести работоспособный Debian:10 из CHROOT в Docker. 
План работы:
1. Скачать пакет debootstrap ``` sudo apt install debootstrap ```;
2. Скачать образ с помощью debootstrap для работы с ним в CHROOT Linux ``` sudo debootstrap <name-OS> <name-dir> <http-OS> ```;
3. Запускаем контейнер CHROOT ``` sudo chroot buster/ /bin/bash```, чтобы выйти из контейнера: ```exit```;
4. Архивируем папку, которой лежить образ ```sudo tar -C <name-dir> -c . | docker import - <name-image>```;
5. Запускаем контейнер, в основе которого лежит образ CHROOT-системы: ```docker run -it --name <name-container> <name-image> /bin/bash```

## Пример переноса iso файла в Docker image.
Задача:
	 Перенести работоспособный  iso-файл в Docker. 

1. Скачать пакет squashfs-tools ```sudo apt install squashfs-tools```;
2. Создать папки ```mkdir rootfs unsquashfs```;
sudo mount -o loop ubuntu-22.04.3-live-server-amd64.iso rootfs
find . -type f | grep filesystem.squashfs
sudo unsquashfs -f -d unsquashfs/ rootfs/casper/filesystem.squashfs
sudo tar -C unsquashfs/ -c . | docker import - ubuntu:iso
docker run -it --rm ubuntu:iso /bin/bash
