#if !defined(ae2f_BmpCL_Buff_h)
#define ae2f_BmpCL_Buff_h

#include <ae2f/Bmp/Src.h>
#include <CL/cl.h>

ae2f_extern ae2f_SHAREDCALL cl_mem ae2f_BmpCL_Buff_Mk(
    cl_mem_flags flag,
    const ae2f_struct ae2f_Bmp_cSrc* src,
    cl_context ctx,
    cl_command_queue queue,
    cl_int* reterr
);

ae2f_extern ae2f_SHAREDCALL ae2f_errint_t ae2f_BmpCL_Buff_Read(
    cl_mem src,
    cl_command_queue queue,
    ae2f_struct ae2f_Bmp_cSrc* dest,
    ae2f_struct ae2f_Bmp_cSrc* dest_require
);

#define ae2f_BmpCL_Buff_Del clReleaseMemObject

#endif