# Диплом "Внедрение непрерывной интеграции программного обеспечения специального назначения на предприятии"
Материалы по ВКР "Внедрение непрерывной интеграции программного обеспечения специального назначения на предприятии". 

Автор: Служеникина Елена Юрьевна 

Группа: РИ-400012

## Введение
В современном мире автоматизация процессов встречается во многих сферах работы человека. Она актуальна для всех заинтересованных лиц, поскольку, используя данную методику, производство экономит время работы сотрудников и их силы, тратящиеся на выполнение регулярных задач. Особенно это касается крупных производств, которые работают с огромным количеством задач.

В последнее время возникла тенденция введения на производстве IT компаний технологии непрерывной интеграции продукта с помощью CI/CD, которая является одним из типов автоматизации процессов в IT сфере. Целью данной технологии является предоставление разработчикам возможности исправлять сразу все недочеты, используя скрипты с автоматическими тестами. Обычно разработчик вынужден тратить достаточно много рабочего времени на проверку продукта или на ожидание результатов проверок от тестировщика. Однако используя технологию CI/CD, время тестирования снижается в несколько раз. Такая проблема не обошла стороной и производственные предприятия.

Тем не менее, если разобраться с причинами задержки выпуска продукта на указанном производстве, можно обнаружить, что разработчик тратить много времени не только на тестирование полученного результата, но и на настройку системы с нуля в случае возникновения фатальных ошибок.

Таким образом, проблема заказчика заключается в оптимизации работы с повторяющимися сборками, удовлетворяющими ГОСТ РФ.

Актуальность работы заключается в необходимости автоматизировать процесс создания информационной системы, целью которой является разработка воспроизводимого, повторяющегося и надежного программного продукта.

Объект исследования – информационные бизнес-процессы оборонно-промышленного предприятия.

Предмет исследования – информационная система непрерывной интеграции для реализации программного обеспечения специального назначения.

Целью выпускной квалификационной работы является внедрение технологии, которая позволит сократить время на разработку программного продукта и внедрение стандартов.

Для достижения заданной цели необходимо решить следующие задачи:
1) проанализировать способы более эффективной разработки программного обеспечения.
2) проанализировать возможность создания контейнера для тестирования разрабатываемых продуктов, используя встроенные функции Linux.
3) разработать контейнеры, содержащие операционные системы, библиотеки, компиляторы, фреймворки.
4) разработать скрипт, создающий дистрибутивы для установки программных средств специального назначения.
5) внедрить локальное хранилище, содержащие Docker образы.
6) внедрить технологию непрерывной интеграции на производстве.

При выполнении работы использовались следующие методы: генерация идей, сравнения, абстрактно-логический анализ и синтез, наблюдение, опросы, интервьюирование.

Для выполнения выпускной квалификационной работы были использованы законодательные и нормативно-правовые акты Российской Федерации, труды российских и зарубежных ученых по теме выпускной квалификационной работы, методическая литература, материалы, полученные в ходе преддипломной практики, ГОСТ РВ РФ, техническая документация, технические требования к продукту от заказчика.

Результатом работы будут разработаны скрипты для работы с технологией контейнеризации и будет внедрение непрерывной интеграции продукта на производственном предприятии.

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
docker run -it --name <name-container> <name-image>
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
Необходимо проверить uid и gid в Dockerfile с uid и gid в хост системе. Для этого необходимо в хост системе прописать команду ```id $USER ```.
```
id $USER 
sudo xhost +local:docker
docker buildx build --tag <name-image> --file ./Dockerfile .
docker run --rm -it --name <name-container> --env DISPLAY=$DISPLAY --privileged --volume /tmp/.X11-unix:/tmp/.X11-unix <name-image>
```
### Отличие project_qt_2 от project_qt_3
* В project_qt_2 показана реализация подключения постоянной среды ```ENV QT_QPA_PLATFORM=xcb```.
* В project_qt_3 показана реализация подключения пользователя хост машины к docker образу.

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
9. Запустить контейнер, в основе которого лежит образ CHROOT-системы: ```docker run -it --name <name-container> <name-image> /bin/bash```
