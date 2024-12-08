#if !defined(ae2fCL_Bmp_Src_h)
#define ae2fCL_Bmp_Src_h
#include "Buff.h"

#define ae2fCL_BmpSrcMk(dest, src, ctx, queue) (ae2fCL_cBmpBuffMk(dest, CL_MEM_READ_ONLY, src, ctx, queue))
#define ae2fCL_BmpSrcDel ae2fCL_cBmpBuffDel

#endif