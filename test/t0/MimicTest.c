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
    err = ae2f_BmpCLFill(&clsrc, queue, 0xFF00FF, 13, 13);
    CHECK_ERR(err, CL_SUCCESS, fail_after_init);

    for(int i = 0; i < 50; i++) {
        bool r =
        clsrc.source->Addr[i * 3] == 0xFF &&
        clsrc.source->Addr[i * 3 + 1] == 0 &&
        clsrc.source->Addr[i * 3 + 2] == 0xFF;

        if(!r) return 1;
    }

    fail_after_init:
    ae2f_cBmpCLBuffDel(&clsrc);
    ae2f_BmpCLDel();

    __failure:
    if(src.Addr) free(src.Addr);
    if(dest.Addr) free(dest.Addr);
    if(context) clReleaseContext(context);
    if(device) clReleaseDevice(device);
    if(queue) clReleaseCommandQueue(queue);

    printf("Test0 exit code: %d\n", err);
    return err;
}

static int Test1() {
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

    ae2f_struct ae2f_cBmpCLBuff clsrc, cldest;

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

    err = ae2f_cBmpCLBuffMk(
        &cldest, CL_MEM_READ_WRITE,
        &src, context, queue 
    );
    CHECK_ERR(err, CL_SUCCESS, fail_after_init);
    err = ae2f_BmpCLFill(&clsrc, queue, 0xFF00FF, 1, 1);
    CHECK_ERR(err, CL_SUCCESS, fail_after_init);
    ae2f_struct ae2f_cBmpSrcCpyPrm prm;
    prm.AddrXForDest = 0;
    prm.AddrXForDest = 0;
    prm.Alpha = 255;
    prm.AxisX = 0;
    prm.AxisY = 0;
    prm.DataToIgnore = 0;
    prm.HeightAsResized = 5;
    prm.WidthAsResized = 10;
    prm.ReverseIdx = 0;
    prm.RotateXYCounterClockWise = 0;

    err = ae2f_BmpCLCpy(&cldest, &clsrc, &prm, queue, 10, 10);
    for(int i = 0; i < 50; i++) {
        bool r =
        cldest.source->Addr[i * 3] == 0xFF &&
        cldest.source->Addr[i * 3 + 1] == 0 &&
        cldest.source->Addr[i * 3 + 2] == 0xFF;

        if(!r) return 1;
    }

    fail_after_init:
    ae2f_cBmpCLBuffDel(&clsrc);
    ae2f_cBmpCLBuffDel(&cldest);
    ae2f_BmpCLDel();

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
    CHECK_ERR(err = Test1(), 0, __);

    __:
    return err;
}