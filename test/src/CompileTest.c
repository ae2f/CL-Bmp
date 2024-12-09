#include <stdio.h>
#include <CL/cl.h>
#include "../test.h"
#include <ae2fCL/Bmp/Bmp.h>

int main() {
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

    err = ae2fCL_BmpMk(context, 1, &device);
    CHECK_ERR(err, CL_SUCCESS, __failure);

    err = ae2fCL_BmpDel();
    CHECK_ERR(err, CL_SUCCESS, __failure);

    __failure:
    if(context) clReleaseContext(context);
    if(device) clReleaseDevice(device);
    return err;
}