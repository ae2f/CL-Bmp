#include <stdio.h>
#include <CL/cl.h>
#include <ae2f/BmpCL/Programme.h>
#include "test.h"

static int Test0() {
    cl_int err = 0;
    cl_platform_id platform = 0;
    cl_device_id device = 0;
    cl_context context = 0;
    cl_program program = 0;

    err = clGetPlatformIDs(1, &platform, 0);
    CHECK_ERR(err, CL_SUCCESS, __failure);
    
    err = clGetDeviceIDs(platform, CL_DEVICE_TYPE_GPU, 1, &device, 0);
    CHECK_ERR(err, CL_SUCCESS, __failure);

    context = clCreateContext(0, 1, &device, 0, 0, &err);
    CHECK_ERR(err, CL_SUCCESS, __failure);

    program = clCreateProgramWithSource(
        context, ae2f_BmpCL_Programme_COUNT, ae2f_BmpCL_Programme, 0, &err
    );
    CHECK_ERR(err, CL_SUCCESS, __failure);

    printf("Operation went successful.\n");

    if (program) clReleaseProgram(program);
    if (context) clReleaseContext(context);
    return 0;

    __failure:
    if (program) clReleaseProgram(program);
    if (context) clReleaseContext(context);
    fprintf(stderr, "Error: %d\n", err);
    return 1;
}

#include <ae2f/BmpCL/BmpCL.h>

static int Test1() {
    cl_int err = 0;
    cl_platform_id platform = 0;
    cl_device_id device = 0;
    cl_context context = 0;

    err = clGetPlatformIDs(1, &platform, 0);
    CHECK_ERR(err, CL_SUCCESS, __failure);
    
    err = clGetDeviceIDs(platform, CL_DEVICE_TYPE_GPU, 1, &device, 0);
    CHECK_ERR(err, CL_SUCCESS, __failure);

    context = clCreateContext(0, 1, &device, 0, 0, &err);
    CHECK_ERR(err, CL_SUCCESS, __failure);

    err = ae2f_BmpCLMk(context, 1, &device);
    CHECK_ERR(err, CL_SUCCESS, __failure);

    err = ae2f_BmpCLDel();
    CHECK_ERR(err, CL_SUCCESS, __failure);

    __failure:
    if(context) clReleaseContext(context);
    if(device) clReleaseDevice(device);
    return err;
}

int CompileTest() {
    int err = 0;
    CHECK_ERR(err = Test0(), 0, ERR);
    CHECK_ERR(err = Test1(), 0, ERR);

    ERR:
    return err;
}