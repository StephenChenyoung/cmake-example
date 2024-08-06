# 头文件目录
include_directories(../code/include)

# 收集source目录中的所有源文件并将其存储在SRC_DIR变量中，后续如果新增源文件无需修改cmake脚本
aux_source_directory(. TEST_DIR)

# 可执行文件
add_executable(${CMAKE_PROJECT_NAME}_test ${TEST_DIR})

# 添加链接库
target_link_libraries(${CMAKE_PROJECT_NAME}_test ${CMAKE_PROJECT_NAME}_src_lib gtest_main)
