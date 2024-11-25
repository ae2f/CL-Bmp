#if !defined(ae2f_BmpCL_Dest_h)
#define ae2f_BmpCL_Dest_h
#include "Buff.h"

#define ae2f_cBmpCLDestMk(dest, src, ctx, queue) (ae2f_cBmpCLBuffMk(dest, CL_MEM_READ_WRITE, src, ctx, queue))
#define ae2f_cBmpCLDestDel ae2f_cBmpCLBuffDel

#endif