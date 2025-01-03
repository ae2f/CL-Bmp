cmake_minimum_required(VERSION 3.10)
project(CL-Bmp VERSION 4.7.17)
enable_testing()
include(cmake/CL-Core.cmake)

if(NOT TARGET ${PROJECT_NAME})

ae2f_CoreLibFetch(ae2f Bmp Rel-v6.17.16)
ae2f_CoreLibFetch(ae2f CL-Core Rel-v4.9.13)

ae2fCL_CoreAppendInclude(
    ${ae2f_ProjRoot}/submod/ae2f/Bmp/include
    ${ae2f_ProjRoot}/submod/ae2f/mov2/include
    ${ae2f_ProjRoot}/submod/ae2f/mov/include
    ${ae2f_ProjRoot}/submod/ae2f/Core/include
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