#ifndef ae2f_BmpCL_BmpCL_h
#define ae2f_BmpCL_BmpCL_h

#include <CL/cl.h>
#include "Programme.h"

ae2f_extern ae2f_SHAREDCALL cl_int ae2f_BmpCLMk(
    cl_context context,
    cl_uint clDeviceNumber,
    const cl_device_id* lpDevice
);
ae2f_extern ae2f_SHAREDCALL cl_int ae2f_BmpCLDel();

#include "Buff.h"

ae2f_extern ae2f_SHAREDCALL cl_int ae2f_BmpCLFill(
    ae2f_struct ae2f_cBmpCLBuff* dest,
    cl_command_queue queue,
    uint32_t colour, 
    uint32_t tcount_w,
    uint32_t tcount_h
);

#endif