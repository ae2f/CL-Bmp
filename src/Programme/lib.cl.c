#include <ae2f/Bmp/Blend.h>
#include <ae2f/Bmp/Dot.h>
#include <stdio.h>
#include <ae2f/Call.h>
#include <ae2f/Cast.h>
#include <ae2f/Bmp/Src.h>

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
    __global ae2f_struct ae2f_cBmpSrc* desthead,
    const uint32_t colour
) {
    switch(desthead->ElSize) {
        case 24: case 32: break;
        default: return;
    }

    const uint32_t wi = get_global_id(0), hi = get_global_id(1);
    const uint32_t ws = (desthead->ElSize >> 3);
    const uint32_t wi_ = wi / ws;
    const uint8_t colouridx = ((wi) % ws);
    desthead->Addr[(ae2f_BmpIdxDrive(desthead->rIdxer, wi_, hi) * ws) + colouridx] = ((uint8_t*)&colour)[colouridx];
}

__kernel void ae2f_BmpCLKernCpy(
    __global ae2f_struct ae2f_cBmpSrc* dest,
    __global ae2f_struct ae2f_cBmpSrc* src,
    ae2f_struct ae2f_cBmpSrcCpyPrm prm
) {
	#define srcprm prm
	ae2f_err_t code;

    const uint32_t wi = get_global_id(0);
    const uint32_t ws = (dest->ElSize >> 3);
    const uint32_t x = wi / ws, y = get_global_id(1);

    const uint32_t k = (wi % ws);

	if (!(src && dest && src->Addr && dest->Addr)) {
		return;
	}

	// check if all alpha is zero
	if (!srcprm.Alpha && src->ElSize != ae2f_eBmpBitCount_RGBA)
		return;

	switch (dest->ElSize) {
	case ae2f_eBmpBitCount_RGB:
	case ae2f_eBmpBitCount_RGBA: break;
	default: return;
	}

	ae2f_float_t 
		dotw = (ae2f_BmpIdxW(src->rIdxer) / (ae2f_float_t)srcprm.WidthAsResized), 
		doth = (ae2f_BmpIdxH(src->rIdxer) / (ae2f_float_t)srcprm.HeightAsResized);

    union {
        uint32_t a;
        uint8_t b[4];
    } el;

    uint32_t _x, _y;
    _x = x; _y = y;

    code = ae2f_cBmpSrcGDot(
        src, &el.a, 
        dotw * _x, 
        doth * _y, 
        dotw * (_x + 1), 
        doth * (_y+1),
        srcprm.ReverseIdx
    );

    ae2f_float_t 
    rotatedW = dotw * cos(srcprm.RotateXYCounterClockWise) + doth * sin(srcprm.RotateXYCounterClockWise),
    rotatedH = doth * cos(srcprm.RotateXYCounterClockWise) - dotw * sin(srcprm.RotateXYCounterClockWise);

    if(rotatedW < 0) rotatedW = -rotatedW;
    if(rotatedH < 0) rotatedH = -rotatedH;

    if(code != ae2f_errGlob_OK) {
        return;
    }

    if(el.a == srcprm.DataToIgnore) return;
    
    if(src->ElSize == ae2f_eBmpBitCount_RGB) {
        el.b[3] = srcprm.Alpha;
    }

    ae2f_float_t 
    _transx = (ae2f_float_t)_x - srcprm.AxisX, 
    _transy = (ae2f_float_t)_y - srcprm.AxisY,
    rotatedX = _transx * cos(srcprm.RotateXYCounterClockWise) + _transy * sin(srcprm.RotateXYCounterClockWise) + srcprm.AxisX,
    rotatedY = _transy * cos(srcprm.RotateXYCounterClockWise) - _transx * sin(srcprm.RotateXYCounterClockWise) + srcprm.AxisY;

    for(int32_t i = 0; !i || i < rotatedW; i++) 
    for(int32_t j = 0; !j || j < rotatedH; j++) {
        #pragma region single dot
        uint32_t foridx = 
        ae2f_BmpIdxDrive(
            dest->rIdxer, (uint32_t)rotatedX + i + srcprm.AddrXForDest, (uint32_t)rotatedY + j + srcprm.AddrYForDest);
        
        if(foridx == -1) return;
        
        ae2f_ptrBmpSrcUInt8  addr = dest->Addr + (dest->ElSize >> 3) * foridx;
        switch (k) {
        default: {
            addr[k] = ae2f_BmpBlend_imp(
                el.b[k], 
                addr[k], 
                ((ae2f_static_cast(ae2f_float_t, el.b[3])) / 255.0), 
                uint8_t
            );
        } break;
        case 3: {
            addr[k] = (ae2f_static_cast(uint16_t, addr[k]) + el.b[k]) >> 1;
        }
        }

        #pragma endregion
    }


    #undef srcprm
}