cmake_minimum_required(VERSION 3.10)
project(CL-Bmp VERSION 4.7.17)
enable_testing()
if(NOT TARGET ${PROJECT_NAME})

add_subdirectory(mod/ae2f/Bmp)
add_subdirectory(mod/ae2fCL/Core)

ae2fCL_CoreAppendInclude(
    ${PROJECT_SOURCE_DIR}/mod/ae2f/Bmp/include
    ${PROJECT_SOURCE_DIR}/mod/ae2f/Bmp/mod/ae2f/mov2/include
    ${PROJECT_SOURCE_DIR}/mod/ae2f/Bmp/mod/ae2f/mov2/mod/ae2f/mov/include
    ${PROJECT_SOURCE_DIR}/mod/ae2f/Bmp/mod/ae2f/mov2/mod/ae2f/mov/mod/ae2f/Core/include
)

ae2f_CoreLibTent(
    ${PROJECT_NAME} ${ae2f_LIBPREFIX}
    include ae2fCL
    "include/ae2fCL/Bmp/Buff.h"
    "include/ae2fCL/Bmp/Dest.h"
    "include/ae2fCL/Bmp/Src.h"
    "include/ae2fCL/Bmp/Bmp.h"
    "src/Buff.c"
    "src/Bmp.c"
)

target_link_libraries(${PROJECT_NAME} PUBLIC CL-Core)
target_link_libraries(${PROJECT_NAME} PUBLIC Bmp)

ae2fCL_CoreAddConfProjTarDep(${PROJECT_NAME} ${PROJECT_SOURCE_DIR}/src)
ae2f_CoreTestTent(${PROJECT_NAME} test/src)

include_directories(include)

endif()