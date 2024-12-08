#ifndef ae2f_BmpCL_BmpCL_h
#define ae2f_BmpCL_BmpCL_h

#include <CL/cl.h>
#include "Programme.h"

#if !CL_VERSION_3_0
#define clCreateCommandQueueWithProperties clCreateCommandQueue
#endif

ae2f_extern ae2f_SHAREDCALL cl_int ae2f_BmpCLMk(
    cl_context context,
    cl_uint clDeviceNumber,
    const cl_device_id* lpDevice
);
ae2f_extern ae2f_SHAREDCALL cl_int ae2f_BmpCLDel();

#include "Buff.h"

ae2f_extern ae2f_SHAREDCALL cl_int ae2f_BmpCLFill(
    cl_command_queue queue,
    ae2f_struct ae2f_cBmpCLBuff* dest,
    uint32_t colour
);

#include <ae2f/Bmp/Src/Rect.h>

ae2f_extern ae2f_SHAREDCALL cl_int ae2fCL_BmpRectCpy(
    cl_command_queue queue,
    ae2f_struct ae2f_cBmpCLBuff* dest,
    ae2f_struct ae2f_cBmpCLBuff* src,
    const ae2f_struct ae2f_cBmpSrcRectCpyPrm* prm
);

#endif