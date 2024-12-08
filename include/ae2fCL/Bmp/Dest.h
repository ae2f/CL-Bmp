#if !defined(ae2fCL_Bmp_Dest_h)
#define ae2fCL_Bmp_Dest_h
#include "Buff.h"

#define ae2fCL_cBmpDestMk(dest, src, ctx, queue) (ae2fCL_cBmpBuffMk(dest, CL_MEM_READ_WRITE, src, ctx, queue))
#define ae2fCL_cBmpDestDel ae2fCL_cBmpBuffDel

#endif