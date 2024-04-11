cmake_minimum_required(VERSION 3.5)

project(qt_boost_cmake LANGUAGES CXX)

find_package(Qt5 REQUIRED COMPONENTS Core Widgets)
find_package(Boost 1.62.0 REQUIRED)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(qt_boost_cmake main.cpp)
target_link_libraries(qt_boost_cmake PRIVATE Qt5::Core Qt5::Widgets)
