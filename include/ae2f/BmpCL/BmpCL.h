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
    cl_command_queue queue,
    ae2f_struct ae2f_cBmpCLBuff* dest,
    uint32_t colour
);

ae2f_extern ae2f_SHAREDCALL cl_int ae2f_BmpCLCpy(
    cl_command_queue queue,
    ae2f_struct ae2f_cBmpCLBuff* dest,
    ae2f_struct ae2f_cBmpCLBuff* src,
    const ae2f_struct ae2f_cBmpSrcCpyPrm* prm
);

#endif