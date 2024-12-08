#if !defined(ae2fCL_Bmp_Buff_h)
#define ae2fCL_Bmp_Buff_h

#include <CL/cl.h>
#include <ae2f/Bmp/Src.h>

struct ae2fCL_cBmpBuff {
    cl_mem head;
    cl_mem body;
    ae2f_struct ae2f_cBmpSrc* source;
};

ae2f_extern ae2f_SHAREDCALL 
cl_int ae2fCL_cBmpBuffMk(
    ae2f_struct ae2fCL_cBmpBuff* dest,
    cl_mem_flags flag,
    ae2f_struct ae2f_cBmpSrc* src,
    cl_context ctx
);


ae2f_extern ae2f_SHAREDCALL 
cl_int ae2fCL_cBmpBuffDel(
    ae2f_struct ae2fCL_cBmpBuff* block
);

#endif