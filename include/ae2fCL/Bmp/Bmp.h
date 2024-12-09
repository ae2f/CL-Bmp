#ifndef ae2fCL_Bmp_Bmp_h
#define ae2fCL_Bmp_Bmp_h

#include <CL/cl.h>
#include "Buff.h"

#if !CL_VERSION_3_0
#define clCreateCommandQueueWithProperties clCreateCommandQueue
#endif

ae2f_extern ae2f_SHAREDCALL cl_int ae2fCL_BmpMk(
    cl_context context,
    cl_uint clDeviceNumber,
    const cl_device_id* lpDevice
);
ae2f_extern ae2f_SHAREDCALL cl_int ae2fCL_BmpDel();

ae2f_extern ae2f_SHAREDCALL cl_int ae2fCL_BmpFill(
    cl_command_queue queue,
    ae2f_struct ae2fCL_cBmpBuff* dest,
    uint32_t colour
);

#endif