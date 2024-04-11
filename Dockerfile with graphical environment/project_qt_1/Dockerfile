FROM debian:10

RUN apt-get update
RUN apt install -y qtbase5-dev \
    libboost-all-dev \
    cmake \
    g++

COPY ./main.cpp /app/
COPY ./CMakeLists.txt /app/

RUN cd /app/ && \
    cmake . && \
    make

ENTRYPOINT ["./app/qt_boost_cmake"]

