# ВКР "Внедрение непрерывной интеграции программного обеспечения специального назначения на предприятии"

## Пример контейнера с поддержкой графического интерфейса приложения 
Задача:
	Создать Dockerfile для проекта, которому необходимы следующие компоненты: Debian:10, qtbase5-dev, libboost-all-dev, cmake и g++

Цель:
	Вывод графического интерфейса приложения на экран.

Трудности:
	В Docker нет поддержки графического интерфейса по умолчанию, поэтому нет возможности запускать графические приложения внутри контейнера.

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
