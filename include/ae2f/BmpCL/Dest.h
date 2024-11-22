#if !defined(ae2f_BmpCL_Dest_h)
#define ae2f_BmpCL_Dest_h
#include "Buff.h"

#define ae2f_cBmpCLDestMk(src, ctx, queue, reterr) (ae2f_cBmpCLBuffMk(CL_MEM_READ_WRITE, src, ctx, queue, reterr))
#define ae2f_cBmpCLDestGets ae2f_cBmpCLBuffGets
#define ae2f_cBmpCLDestDel ae2f_cBmpCLBuffDel

#endif