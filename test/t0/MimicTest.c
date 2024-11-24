#include "test.h"
#include <CL/cl.h>
#include <ae2f/BmpCL/BmpCL.h>
#include <ae2f/BmpCL/Buff.h>
#include <ae2f/BmpCL/Src.h>
#include <stdio.h>

static int Test0() {
    cl_int err = 0;
    cl_platform_id platform = 0;
    cl_device_id device = 0;
    cl_context context = 0;
    cl_program program = 0;
    cl_command_queue queue = 0;

    ae2f_struct ae2f_cBmpSrc 
    src = {
        .ElSize = 24,
        .rIdxer = {
            .Count = 50,
            .CurrX = 0,
            .IdxXJump = 10,
            .Width = 10
        },

        .Addr = calloc(50, 3)
    }, 
    dest = {
        .ElSize = 24,
        .rIdxer = {
            .Count = 50,
            .CurrX = 0,
            .IdxXJump = 10,
            .Width = 10
        },

        .Addr = calloc(50, 3)
    };

    ae2f_struct ae2f_cBmpCLBuff clsrc;

    err = clGetPlatformIDs(1, &platform, 0);
    CHECK_ERR(err, CL_SUCCESS, __failure);
    
    err = clGetDeviceIDs(platform, CL_DEVICE_TYPE_GPU, 1, &device, 0);
    CHECK_ERR(err, CL_SUCCESS, __failure);

    context = clCreateContext(0, 1, &device, 0, 0, &err);
    CHECK_ERR(err, CL_SUCCESS, __failure);
    queue = clCreateCommandQueueWithProperties(context, device, 0, &err);
    CHECK_ERR(err, CL_SUCCESS, __failure);

    err = ae2f_BmpCLMk(context, 1, &device);
    CHECK_ERR(err, CL_SUCCESS, __failure);

    err = ae2f_cBmpCLBuffMk(
        &clsrc, CL_MEM_READ_WRITE,
        &src, context, queue
    );
    CHECK_ERR(err, CL_SUCCESS, fail_after_init);
    // err = ae2f_BmpCLFill(&clsrc, queue, 0x50, 5, 5);
    // printf("Got: %d %d %d\n", clsrc.source->Addr[0], clsrc.source->Addr[1], clsrc.source->Addr[2]);

    CHECK_ERR(err, CL_SUCCESS, fail_after_init);

    fail_after_init:
    ae2f_BmpCLDel();
    ae2f_cBmpCLBuffDel(&clsrc);

    __failure:
    if(src.Addr) free(src.Addr);
    if(dest.Addr) free(dest.Addr);
    if(context) clReleaseContext(context);
    if(device) clReleaseDevice(device);
    if(queue) clReleaseCommandQueue(queue);

    printf("Test0 exit code: %d\n", err);
    return err;
}

int MimicTest() {
    int err = 0;
    CHECK_ERR(err = Test0(), 0, __);
    // CHECK_ERR(err = Test1(), 0, __);

    __:
    return err;
}