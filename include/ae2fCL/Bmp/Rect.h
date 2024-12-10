#ifndef ae2fCL_Bmp_Rect_h
#define ae2fCL_Bmp_Rect_h

#include "Bmp.h"
#include <ae2f/Bmp/Src/Rect.h>

ae2f_extern ae2f_SHAREDCALL cl_int ae2fCL_BmpRectCpy(
    cl_command_queue queue,
    ae2f_struct ae2fCL_cBmpBuff* dest,
    ae2f_struct ae2fCL_cBmpBuff* src,
    const ae2f_struct ae2f_cBmpSrcRectCpyPrm* prm
) noexcept;

#endif