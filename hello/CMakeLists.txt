cmake_minimum_required(VERSION 3.12)

project(hello VERSION 1.0.0)

set(CMAKE_CXX_STANDARD )

include_directories(./include)

set(HEADER_FILES ./include/header_sample.h)

add_executable(hello main.cpp source_sample.cpp)
