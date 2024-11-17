cmake_minimum_required(VERSION 3.10)
project(BmpCL)
enable_testing()

option(ae2f_IS_SHARED "Is a shared library or static one." OFF)
set(ae2f_OpenCL_LIB_DIR "C:/Program Files (x86)/Intel/oneAPI/2025.0/lib/OpenCL.lib" CACHE STRING "Where library for OpenCL locates.")
set(ae2f_OpenCL_INCLUDE_DIR "C:/Program Files (x86)/Intel/oneAPI/2025.0/include/sycl/" CACHE STRING "Where headers for OpenCL headers locate.")

if(ae2f_IS_SHARED)
    set(ae2f_PREFIX_LIB SHARED)
    add_compile_definitions(-D_ae2f_IS_SHARED=1)
else()
    set(ae2f_PREFIX_LIB )
    add_compile_definitions(-D_ae2f_IS_SHARED=0)
endif()

# Namespace Package
include(GNUInstallDirs)

add_library(
	${PROJECT_NAME}
    ${ae2f_PREFIX_LIB}
    "include/ae2f/BmpCL/Buff.h"
    "src/Buff.c"
    "src/xProgramme.cpp"
    "src/BmpCL.c"
)

include_directories(include)
add_subdirectory(mod/ae2f/Bmp)
target_link_libraries(${PROJECT_NAME} PUBLIC Bmp)

find_package(OpenCL)
if(OpenCL_FOUND)
    target_link_libraries(${PROJECT_NAME} PUBLIC OpenCL::OpenCL)
else()
    message("OpenCL::OpenCL not found.")
    message("Finding it by two variables...")
    target_link_libraries(${PROJECT_NAME} ${ae2f_OpenCL_LIB_DIR})
    target_include_directories(${PROJECT_NAME} ${ae2f_OpenCL_INCLUDE_DIR})
endif()

# Header
target_include_directories(${PROJECT_NAME}
    INTERFACE
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

install(TARGETS ${PROJECT_NAME}
    EXPORT ${PROJECT_NAME}Targets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

install(DIRECTORY include/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(EXPORT ${PROJECT_NAME}Targets
    FILE ${PROJECT_NAME}Targets.cmake
    NAMESPACE ae2f::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake
)

include(CMakePackageConfigHelpers)
configure_package_config_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/Config.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
    INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake
)

install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake
)

add_subdirectory(test)

# Threading
# Pipe (When data is inside the pipe, do not return)
