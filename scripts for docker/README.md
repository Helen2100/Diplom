# ВКР "Внедрение непрерывной интеграции программного обеспечения специального назначения на предприятии"

## Описание файлов и папок, содержащихся в папке /scripts for docker

* /schemes - папка, содержащая схемы алгоритмов работы скриптов (находящиеся в папке ./scripts) для работы с программном обеспечением Docker;
  * docker-create-1.png - алгоритм скрипта docker-create-image-and-container-both.sh (часть 1);
  * docker-create-2.png - алгоритм скрипта docker-create-image-and-container-both.sh (часть 2);
  * docker-delete.png  - алгоритм скрипта docker-delete-container-image.sh;
  * docker-open-container.png  - алгоритм скрипта docker-open-container.sh;
  * docker-pull-1.png  - алгоритм скрипта docker-push.sh (часть 1);
  * docker-pull-2.png  - алгоритм скрипта docker-push.sh (часть 2);
  * docker-test-checksums.png  - алгоритм скрипта test-is-equal-docker-images.sh;
  * docker-install.png  - алгоритм скрипта docker-push.sh (часть 1);

* /scripts - папка, содержащая скрипты для работы с технологией контениризации (программное обеспечение Docker);

  Основные скрипты:
  * docker-create-image-and-container-both.sh - скрипт создания контейнеров из образа, находящегося в репозитории Harbor, или из образа, который лежит на локальном компьютере;
  * docker-push.sh - скрипт для отправки измененного контейнера или образа в репозиторий Harbor;
  * docker-open-container.sh - скрипт для входа в уже созданный пользователем контейнер;
  * docker-delete-container-image.sh - скрипт для удаление контейнера или образа или очистка ПК от кэша Docker;
  * test-is-equal-docker-images.sh - скрипт для проверки контрольных сумм образа на локальном компьютере с образом в репозитории Harbor;
  * info­account.sh — скрипт, в котором прописаны данные пользователя для входа и загрузки образов в Harbor;
  
  Второстепенные скрипты (используются основными скриптами):
  * Dockerfile­copy­file — файл с инструкцией для создания Docker образа;
  * Dockerfile­create — файл с инструкцией для создания Docker образа. Данная инструкция подгружает графическую оболочку и файлы, которые пользователь положил рядом с этим скриптом;
  * .dockerignore — инструкция для Docker. В этом скрипте перечислены файлы, которые нужно игнорировать при использовании команды ```COPY . /app``` в скрипте Dockerfile.
  
  Скрипты для установки программного обеспечения Docker:
  * docker-install.sh - скрипт для опрерационных систем Linux Astra Orel, Linux Debian 10, Linux Ubuntu 20.04 и Linux Ubuntu 22.04;
  * docker-install-astra.sh - скрипт для опрерационной системы Linux Astra Orel;
  * docker-install-debian-10.sh  - скрипт для опрерационной системы Linux Debian 10;
  * docker-install-ubuntu-20.sh  - скрипт для опрерационной системы Linux Ubuntu 20.04;
  * docker-install-ubuntu-22.04.sh - скрипт для опрерационной системы Linux Ubuntu 22.04.
  
* manual for docker script.pdf - pdf файл, в котором описана технология контейнеризации и описан алгоритм со скриптами, которые облегчают разработчикам взаимодействие с программным обеспечением Docker.
