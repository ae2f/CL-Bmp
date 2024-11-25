#include "../../mod/ae2f/Bmp/src/Src/Double.c"
#include <stdio.h>
#ifndef ae2f_BmpCLKernDef_h
#define ae2f_BmpCLKernDef_h

#define __kernel
#define __global
#define __local
#define get_global_id(i)    0
#define get_global_size(i)  0

#endif

void ae2f_BmpCLKernFetchCBmpSrc(
    ae2f_struct ae2f_cBmpSrc* loc,
    __global ae2f_struct ae2f_cBmpSrc* globhead
) {
    loc->Addr = globhead->Addr;
    loc->ElSize = globhead->ElSize;
    loc->rIdxer.Count = globhead->rIdxer.Count;
    loc->rIdxer.CurrX = globhead->rIdxer.CurrX;
    loc->rIdxer.IdxXJump = globhead->rIdxer.IdxXJump;
    loc->rIdxer.Width = globhead->rIdxer.Width;
}

/// @brief 
/// @param src 
/// @param _rect 's length must be over 4.
/// @param tw 
/// @param th 
/// @param twi 
/// @param thi 
bool ae2f_BmpCLKernRectScopeGet_imp(
    const ae2f_struct ae2f_cBmpSrc* src,
    uint32_t* _rect,

    uint32_t tw, uint32_t th,
    uint32_t twi, uint32_t thi
) {
    const uint32_t 
    w = ae2f_BmpIdxW(src->rIdxer),
    h = ae2f_BmpIdxH(src->rIdxer);

    #define rectxm _rect[0]
    #define rectxM _rect[1]
    #define rectym _rect[2]
    #define rectyM _rect[3]

    #pragma region Width set
    if(tw > w) {
        // extra worker. we don't need that.
        if(twi >= w) { return 1; }
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
        if(thi >= h) { return 1; }
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

    #undef rectxm
    #undef rectxM
    #undef rectym
    #undef rectyM

    return 0;
}


#define ae2f_BmpCLKernRectScopeGet(src, _rect) ae2f_BmpCLKernRectScopeGet_imp(src, _rect, get_global_size(0), get_global_size(1), get_global_id(0), get_global_id(1))
#define ae2f_BmpCLKernRectTent(rect) rect[0], rect[2], rect[1], rect[3]

__kernel void ae2f_BmpCLKernFill(
    __global ae2f_struct ae2f_cBmpSrc* desthead,
    ae2f_BmpDotRGBA_t colour
) {
    ae2f_struct ae2f_cBmpSrc dest[1];
    // xm xM ym yM
    uint32_t rect[4];
    ae2f_BmpCLKernFetchCBmpSrc(dest, desthead);
    if(ae2f_BmpCLKernRectScopeGet(dest, rect)) return;

    // Actual call
    ae2f_cBmpSrcFillPartial(dest, colour, ae2f_BmpCLKernRectTent(rect));
}

__kernel void ae2f_BmpCLKernCpy(
    __global ae2f_struct ae2f_cBmpSrc* desthead,
    __global ae2f_struct ae2f_cBmpSrc* srchead,
    ae2f_struct ae2f_cBmpSrcCpyPrm prm
) {
    // xm xM ym yM
    uint32_t rect[4];
    ae2f_struct ae2f_cBmpSrc m[1];
    #define dest m
    #define src (m + 1)
    ae2f_BmpCLKernFetchCBmpSrc(dest, desthead);
    ae2f_BmpCLKernFetchCBmpSrc(src, srchead);

    if(ae2f_BmpCLKernRectScopeGet(dest, rect)) return;

    ae2f_cBmpSrcCpyPartial(dest, src, &prm, ae2f_BmpCLKernRectTent(rect));

    #undef dest
    #undef src
}