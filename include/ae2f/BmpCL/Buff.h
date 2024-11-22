#if !defined(ae2f_BmpCL_Buff_h)
#define ae2f_BmpCL_Buff_h

#include <ae2f/Bmp/Src.h>
#include <CL/cl.h>

ae2f_extern ae2f_SHAREDCALL cl_mem ae2f_cBmpCLBuffMk(
    cl_mem_flags flag,
    const ae2f_struct ae2f_cBmpSrc* src,
    cl_context ctx,
    cl_command_queue queue,
    cl_int* reterr
);

ae2f_extern ae2f_SHAREDCALL ae2f_err_t ae2f_cBmpCLBuffGets(
    cl_mem src,
    cl_command_queue queue,
    ae2f_struct ae2f_cBmpSrc* dest,
    ae2f_struct ae2f_cBmpSrc* dest_require
);

#define ae2f_cBmpCLBuffDel clReleaseMemObject

#endif


