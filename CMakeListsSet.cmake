#文件目录
├─code
│  ├─include
│  └─source
├─lib
│  └─googletest
│      ├─.github
│      │  └─ISSUE_TEMPLATE
│      ├─ci
│      ├─docs
│      │  ├─assets
│      │  │  └─css
│      │  ├─reference
│      │  ├─_data
│      │  ├─_layouts
│      │  └─_sass
│      ├─googlemock
│      │  ├─cmake
│      │  ├─docs
│      │  ├─include
│      │  │  └─gmock
│      │  │      └─internal
│      │  │          └─custom
│      │  ├─src
│      │  └─test
│      └─googletest
│          ├─cmake
│          ├─docs
│          ├─include
│          │  └─gtest
│          │      └─internal
│          │          └─custom
│          ├─samples
│          ├─src
│          └─test
└─test

####***********************test目录***********************
# 头文件目录
include_directories(../code/include)

# 收集source目录中的所有源文件并将其存储在SRC_DIR变量中，后续如果新增源文件无需修改cmake脚本
aux_source_directory(. TEST_DIR)

# 可执行文件
add_executable(${CMAKE_PROJECT_NAME}_test ${TEST_DIR})

# 添加链接库
target_link_libraries(${CMAKE_PROJECT_NAME}_test ${CMAKE_PROJECT_NAME}_src_lib gtest_main)


####***********************main目录***********************

# CMake版本号
cmake_minimum_required(VERSION 3.20)

# c++版本
set(CMAKE_CXX_STANDARD 20)

# 项目信息
project(DemoApp)

# 子目录
add_subdirectory(code)
add_subdirectory(test)
add_subdirectory(lib)

# 指定头文件目录
include_directories(./code/include)

#全局指定生成路径
#set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/output/lib) #动态库
#set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/output/static) #静态库
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/output/bin) #二进制

# 生成的执行文件
add_executable(${CMAKE_PROJECT_NAME} main.cpp)

# 添加链接库
target_link_libraries(${CMAKE_PROJECT_NAME} ${CMAKE_PROJECT_NAME}_src_lib)



####***********************src目录***********************
#生成链接库
add_library(${CMAKE_PROJECT_NAME}_src_lib STATIC ${SRC_DIR})

#重命名输出文件名
set_target_properties(${CMAKE_PROJECT_NAME}_src_lib PROPERTIES OUTPUT_NAME "${CMAKE_PROJECT_NAME}_src")

#指定库文件输出路径
set_target_properties(${CMAKE_PROJECT_NAME}_src_lib PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/output/lib)
set_target_properties(${CMAKE_PROJECT_NAME}_src_lib PROPERTIES ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/output/static)

#打印信息
message(INFO "source lib = ${CMAKE_PROJECT_NAME}_src_lib")
message(INFO "PROJECT_SOURCE_DIR = ${PROJECT_SOURCE_DIR}")
get_target_property(var ${CMAKE_PROJECT_NAME}_src_lib LIBRARY_OUTPUT_DIRECTORY)
message(INFO "LIBRARY_OUTPUT_DIRECTORY = ${var}")
