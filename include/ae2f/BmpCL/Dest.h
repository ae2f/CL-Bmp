#if !defined(ae2f_BmpCL_Dest_h)
#define ae2f_BmpCL_Dest_h
#include "Buff.h"

#define ae2f_BmpCL_Dest_Mk(...) (ae2f_BmpCL_Buff_Mk(CL_MEM_READ_WRITE, __VA__ARGS__))
#define ae2f_BmpCL_Dest_Read ae2f_BmpCL_Buff_Read
#define ae2f_BmpCL_Dest_Del ae2f_BmpCL_Buff_Del

#endif