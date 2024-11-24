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
    __global ae2f_struct ae2f_cBmpSrc* dest,
    ae2f_BmpDotRGBA_t colour
) {
    
    // global w, h
    const uint32_t 
    w = ae2f_BmpIdxW(dest->rIdxer),
    h = ae2f_BmpIdxH(dest->rIdxer),
    
    // thread w, h
    tw = get_global_size(0),
    th = get_global_size(1),
    
    // thread w index(x), h index(y)
    twi = get_global_id(0),
    thi = get_global_id(1);

    // Think about it. It is ridiculous.
    if(!(twi && thi)) return;

    // desired rect for function call
    uint32_t
    rectxm = 0, rectxM = w,
    rectym = 0, rectyM = h;

    #pragma region Width set
    if(tw > w) {
        // extra worker. we don't need that.
        if(twi >= w) { return; }
        rectxm = twi;
        rectxM = twi + 1;
    } else {
        uint32_t seedw = w / tw;
        rectxm = seedw * twi;

        if(twi != tw - 1) {
            rectxM = rectxm + seedw;
        }
    }
    #pragma endregion

    #pragma region Height set
    if(th > h) {
        // extra worker. we don't need that.
        if(thi >= h) { return; }
        rectym = thi;
        rectyM = thi + 1;
    } else {
        uint32_t seedh = h / th;
        rectym = seedh * thi;

        if(thi != th - 1) {
            rectyM = rectym + seedh;
        }
    }
    #pragma endregion
    // Actual call
    ae2f_cBmpSrcFillPartial(dest, colour, rectxm, rectym, rectxM, rectyM);
}