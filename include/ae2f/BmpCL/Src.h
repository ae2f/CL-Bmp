#if !defined(ae2f_BmpCL_Src_h)
#define ae2f_BmpCL_Src_h
#include "Buff.h"

#define ae2f_BmpCL_Src_Mk(...) (ae2f_BmpCL_Buff_Mk(CL_MEM_READ_ONLY, __VA__ARGS__))
#define ae2f_BmpCL_Src_Read ae2f_BmpCL_Buff_Read
#define ae2f_BmpCL_Src_Del ae2f_BmpCL_Buff_Del

#endif