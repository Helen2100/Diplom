FROM 192.168.0.168:4431/example-gitlab/gcc-13.02:v1

# Установим рабочую директорию для сборки GoogleTest
WORKDIR /gtest_build

# Скопируем директорию /src в контейнер
ADD ./src /app/src

# Установим рабочую директорию для сборки проекта
WORKDIR /app/build

# Выполним сборку нашего проекта, а также его тестирование
RUN cmake ../src && \
    cmake --build . && \
    CTEST_OUTPUT_ON_FAILURE=TRUE cmake --build . --target test

# Установим точку входа
CMD ["./hello_world_app"]
