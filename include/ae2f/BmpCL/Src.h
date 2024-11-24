#if !defined(ae2f_BmpCL_Src_h)
#define ae2f_BmpCL_Src_h
#include "Buff.h"

#define ae2f_BmpCLSrcMk(dest, src, ctx, queue) (ae2f_cBmpCLBuffMk(dest, CL_MEM_READ_ONLY, src, ctx, queue))
#define ae2f_BmpCLSrcDel ae2f_cBmpCLBuffDel

#endif