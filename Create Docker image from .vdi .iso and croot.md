# Диплом "Внедрение непрерывной интеграции программного обеспечения специального назначения на предприятии"

## Пример переноса операционной системы с ее файлами из chroot системы в Docker image.
Задача:
Перенести работоспособную систему из CHROOT в Docker. 

План работы:
1. Скачать пакет debootstrap ``` sudo apt install debootstrap ```;
2. Скачать образ с помощью debootstrap для работы с ним в CHROOT Linux ``` sudo debootstrap <name-OS> <name-dir> <http-OS> ```;
3. Запустить контейнер CHROOT ``` sudo chroot <name-dir> /bin/bash```, чтобы выйти из контейнера: ```exit```;
4. Cжать с помощью tar папку и импортировать образ с помощью docker ```sudo tar -C <name-dir> -c . | docker import - <name-image>```;
5. Запустить контейнер, в основе которого лежит образ CHROOT-системы: ```docker run -it --name <name-container> <name-image> /bin/bash```

## Пример переноса iso файла в Docker image.
Задача:
Перенести работоспособный  iso-файл в Docker. 

1. Скачать пакет squashfs-tools ```sudo apt install squashfs-tools```;
2. Создать папки ```mkdir rootfs unsquashfs```;
3. Рядом с этими папками положить iso файл;
4. Монтировать iso-файл как блочное устройство в папку rootfs```sudo mount -o loop <name-iso> rootfs```;
5. Проверить, что в папке rootfs лежит сжатая файловая система (squashfs) ```find rootfs/ -type f | grep filesystem.squashfs```;
6. Использовать unsquashfs, чтобы извлечь файлы файловой системы в папку unsquashfs ```sudo unsquashfs -f -d unsquashfs/ <path/to/filesystem.squashfs>```;
7. Cжать с помощью tar папку и импортировать образ с помощью docker ```sudo tar -C unsquashfs/ -c . | docker import - <name-image>```;
8. Запустить контейнер, в основе которого лежит образ CHROOT-системы: ```docker run -it --name <name-container> <name-image> /bin/bash```


## Пример переноса vdi файла в Docker image.
Задача:
Перенести работоспособный  vdi-файл в Docker. 

1. Скачать пакеты qemu ```sudo apt install qemu qemu-utils qemu-kvm```;
2. Создать папку для монтирования ```mkdir <name-dir>```;
3. Рядом с этой папкой положить vdi файл;
4. Подключить модуль NBD c 16 разделами - создать блочное устройство```sudo modprobe nbd max_part=16```;
5.  "Подключить" vdi-файл к устройству ```sudo qemu-nbd -c /dev/nbd0 <name-vdi>.vdi```;
6.  Монтировать vdi-файл как блочное устройство в соданную нами папку ```sudo mount /dev/nbd0p3 <name-dir>```;
7. Создать недостающие папки в ```<name-dir>```, например, ```mkdir lib32 lib64 libx32 media srv run sys```;
8. Cжать с помощью tar папку и импортировать образ с помощью docker ```sudo tar -C <name-dir> -c . | docker import - <name-image>```;
9. Запустить контейнер, в основе которого лежит образ vdi-файла: ```docker run -it --name <name-container> <name-image> /bin/bash```
