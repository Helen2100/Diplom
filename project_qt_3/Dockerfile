FROM debian:10

RUN apt update
RUN apt-get install -qqy x11-apps 
RUN apt-get install sudo
RUN apt install -y qtbase5-dev \
    libboost-all-dev \
    cmake \
    g++

RUN     export uid=1001 gid=1001
RUN     mkdir -p /home/docker_user
RUN     echo "docker_user:x:${uid}:${gid}:docker_user,,,:/home/docker_user:/bin/bash" >> /etc/passwd
RUN     echo "docker_user:x:${uid}:" >> /etc/group
RUN     echo "docker_user ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/docker_user
RUN     chmod 0440 /etc/sudoers.d/docker_user
RUN     chown ${uid}:${gid} -R /home/docker_user 

USER    docker_user 
ENV     HOME /home/docker_user 

COPY ./main.cpp /app/
COPY ./CMakeLists.txt /app/

RUN cd /app/ && \
    cmake . && \
    make

ENTRYPOINT ["./app/qt_boost_cmake"]
