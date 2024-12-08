project(CL-BmpTest)

add_executable(
    ${PROJECT_NAME}
    "main.c"
    "CompileTest.c"
    "MimicTest.c"
)

add_test(NAME ${PROJECT_NAME} COMMAND ${PROJECT_NAME})