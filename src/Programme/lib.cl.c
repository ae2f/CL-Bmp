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

    union {
        uint32_t a;
        uint8_t b[4];
    } el;

    uint32_t _x, _y;
    _x = x; _y = y;

	ae2f_float_t 
		dotw = (ae2f_BmpIdxW(src->rIdxer) / (ae2f_float_t)prm.WidthAsResized), 
		doth = (ae2f_BmpIdxH(src->rIdxer) / (ae2f_float_t)prm.HeightAsResized);

    code = ae2f_cBmpSrcGDot(
        src, &el.a, 
        dotw * _x, 
        doth * _y, 
        dotw * (_x + 1), 
        doth * (_y+1),
        prm.ReverseIdx
    );

    ae2f_float_t 
    rotatedW = dotw * cos(prm.RotateXYCounterClockWise) + doth * sin(prm.RotateXYCounterClockWise),
    rotatedH = doth * cos(prm.RotateXYCounterClockWise) - dotw * sin(prm.RotateXYCounterClockWise);

    if(rotatedW < 0) rotatedW = -rotatedW;
    if(rotatedH < 0) rotatedH = -rotatedH;

    if(code != ae2f_errGlob_OK) {
        return;
    }

    if(el.a == prm.DataToIgnore) return;
    
    if(src->ElSize == ae2f_eBmpBitCount_RGB) {
        el.b[3] = prm.Alpha;
    }

    ae2f_float_t 
    _transx = (ae2f_float_t)_x - prm.AxisX, 
    _transy = (ae2f_float_t)_y - prm.AxisY,
    rotatedX = _transx * cos(prm.RotateXYCounterClockWise) + _transy * sin(prm.RotateXYCounterClockWise) + prm.AxisX,
    rotatedY = _transy * cos(prm.RotateXYCounterClockWise) - _transx * sin(prm.RotateXYCounterClockWise) + prm.AxisY;

    #pragma region single dot
    uint32_t foridx = 
    ae2f_BmpIdxDrive(
        dest->rIdxer, (int32_t)rotatedX + prm.AddrXForDest, (int32_t)rotatedY + prm.AddrYForDest);
    
    if(foridx == -1) goto __breakloopforx;
    ae2f_ptrBmpSrcUInt8 
        addr = dest->Addr + (dest->ElSize >> 3) * foridx; 

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
    #pragma endregion
    }

    __breakloopforx:;
}