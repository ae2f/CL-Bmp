#include "test.h"
#include <CL/cl.h>
#include <ae2f/BmpCL/BmpCL.h>
#include <ae2f/BmpCL/BmpCL.h>
#include <ae2f/BmpCL/Buff.h>
#include <ae2f/BmpCL/Src.h>
#include <stdio.h>
#include <time.h>
#include <ae2f/BitVec.h>
#include <stdlib.h>

#define __w 2000
#define __h 2000

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
            .Count = __w * __h,
            .CurrX = 0,
            .IdxXJump = __w,
            .Width = __w
        },

        .Addr = calloc(__w * __h, 3)
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
        &src, context
    );
    CHECK_ERR(err, CL_SUCCESS, fail_after_init);
    clock_t a = clock();
    clock_t b = clock();
    err = ae2f_BmpCLFill(queue, &clsrc, 0xFF00FF);
    printf("%d\n", b - a);
    a = b;
    printf(
        "Got: %d %d %d %d %d %d %d\n",
        clsrc.source->Addr[0],
        clsrc.source->Addr[1],
        clsrc.source->Addr[2],

        clsrc.source->Addr[3],
        clsrc.source->Addr[4],
        clsrc.source->Addr[5],
        clsrc.source->Addr[6]
    );
    CHECK_ERR(err, CL_SUCCESS, fail_after_init);

    fail_after_init:
    ae2f_cBmpCLBuffDel(&clsrc);
    ae2f_BmpCLDel();

    __failure:
    if(src.Addr) free(src.Addr);
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
            .Count = __w * __h,
            .CurrX = 0,
            .IdxXJump = __w,
            .Width = __w
        },

        .Addr = calloc(__w * __h, 3)
    },
    
    dest = {
        .ElSize = 24,
        .rIdxer = {
            .Count = __w * __h,
            .CurrX = 0,
            .IdxXJump = __w,
            .Width = __w
        },

        .Addr = calloc(__w * __h, 3)
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
        &src, context
    );
    CHECK_ERR(err, CL_SUCCESS, fail_after_init);

    err = ae2f_cBmpCLBuffMk(
        &cldest, CL_MEM_READ_WRITE,
        &dest, context
    );
    CHECK_ERR(err, CL_SUCCESS, fail_after_init);

    clock_t a = clock();
    clock_t b = clock();
    err = ae2f_BmpCLFill(queue, &clsrc, 0xFF00FF);
    ae2f_struct ae2f_cBmpSrcRectCpyPrm prm = {
        .AddrDest.x = 0,
        .AddrDest.y = 0,
        .Alpha = 255,
        .Axis.x = 0,
        .Axis.y = 0,
        .DataToIgnore = 2,
        .Resz.y = __h,
        .Resz.x = __w,
        .ReverseIdx = 0,
        .RotateXYCounterClockWise = 0
    };
    err = ae2fCL_BmpRectCpy(queue, &cldest, &clsrc, &prm);
    printf("%d\n", b - a);
    a = b;
    printf(
        "Got: %d %d %d %d %d %d %d\n",
        cldest.source->Addr[0],
        cldest.source->Addr[1],
        cldest.source->Addr[2],

        cldest.source->Addr[3],
        cldest.source->Addr[4],
        cldest.source->Addr[5],
        cldest.source->Addr[6]
    );
    CHECK_ERR(err, CL_SUCCESS, fail_after_init);

    fail_after_init:
    ae2f_cBmpCLBuffDel(&clsrc);
    ae2f_BmpCLDel();

    __failure:
    if(src.Addr) free(src.Addr);
    if(dest.Addr) free(dest.Addr);
    if(context) clReleaseContext(context);
    if(device) clReleaseDevice(device);
    if(queue) clReleaseCommandQueue(queue);

    printf("Test1 exit code: %d\n", err);
    return err;
}

int MimicTest() {
    int err = 0;
    CHECK_ERR(err = Test0(), 0, __);
    CHECK_ERR(err = Test1(), 0, __);

    __:
    return err;
};