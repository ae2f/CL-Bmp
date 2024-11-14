project(ae2f_BmpCL_Test_0)

add_executable(
    ${PROJECT_NAME}
    "main.c"
    "CompileTest.c"
    "MimicTest.c"
)

add_test(NAME ${PROJECT_NAME} COMMAND ${PROJECT_NAME})