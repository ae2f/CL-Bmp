#include "../../mod/ae2f/Bmp/src/Src/Double.c"

#ifndef ae2f_BmpCLKernDef_h
#define ae2f_BmpCLKernDef_h

#define __kernel
#define __global
#define __local
#define get_global_id(i)    0
#define get_global_size(i)  0

#endif

__kernel void ae2f_BmpCLKernFill(
    __global ae2f_struct ae2f_cBmpSrc* src,
    ae2f_BmpDotRGBA_t colour
) {
    // global w, h
    const uint32_t 
    w = ae2f_BmpIdxW(src->rIdxer),
    h = ae2f_BmpIdxH(src->rIdxer),
    
    // thread w, h
    tw = get_global_size(0),
    th = get_global_size(1),
    
    // thread w index(x), h index(y)
    twi = get_global_id(0),
    thi = get_global_id(1);
}