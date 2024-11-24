#if !defined(ae2f_BmpCL_Buff_h)
#define ae2f_BmpCL_Buff_h

#include <ae2f/Bmp/Src.h>
#include <CL/cl.h>

struct ae2f_cBmpCLBuff {
    cl_mem head;
    cl_mem body;
    ae2f_struct ae2f_cBmpSrc* source;
};

ae2f_extern ae2f_SHAREDCALL 
cl_int ae2f_cBmpCLBuffMk(
    ae2f_struct ae2f_cBmpCLBuff* dest,
    cl_mem_flags flag,
    ae2f_struct ae2f_cBmpSrc* src,
    cl_context ctx,
    cl_command_queue queue
);


ae2f_extern ae2f_SHAREDCALL 
cl_int ae2f_cBmpCLBuffDel(
    ae2f_struct ae2f_cBmpCLBuff* block
);

#endif