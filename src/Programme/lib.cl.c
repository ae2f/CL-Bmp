#include <ae2f/Bmp/Src.h>
#include <ae2f/Bmp/Blend.h>

#ifndef ae2f_BmpCLKernDef_h
#define ae2f_BmpCLKernDef_h

#define __kernel
#define __global
#define __local
#define get_global_id(i)    0
#define get_global_size(i)  0

#endif

union __colour {
	uint32_t a;
	uint8_t b[4];
};

ae2f_err_t __ae2f_cBmpSrcGDot(
	__global const ae2f_struct ae2f_cBmpSrc* src,
	uint32_t* retColour,
	ae2f_float_t _min_x,
	ae2f_float_t _min_y,
	ae2f_float_t _max_x,
	ae2f_float_t _max_y,

	uint8_t reverseIdx
) {
	const uint32_t 
	xleft = ae2f_BmpIdxW(src->rIdxer), 
	yleft = ae2f_BmpIdxH(src->rIdxer);

	if(!(src && retColour && src->Addr))
	return ae2f_errGlob_PTR_IS_NULL;

	struct {
		ae2f_float_t R, G, B, A, Count;
	} Channel = {0, 0, 0, 0, 0};

	switch(src->ElSize) {
		case ae2f_eBmpBitCount_RGB:
		case ae2f_eBmpBitCount_RGBA:
		break;
		default: return ae2f_errGlob_IMP_NOT_FOUND;
	}

	if(_min_x < 0) _min_x = 0;
	if(_min_y < 0) _min_y = 0;
	if(_max_x < 0) _max_x = 0;
	if(_max_y < 0) _max_y = 0;

	if(_min_x >= xleft) 
	_min_x = xleft;

	if(_max_x >= xleft)
	_max_x = xleft;

	if(_min_y >= yleft) 
	_min_y = yleft;

	if(_max_y >= yleft) 
	_max_y = yleft;

	if(_min_x >= _max_x || _min_y >= _max_y) {
		retColour = 0;
		return ae2f_errGlob_OK;
	}

	struct {
		size_t Width, Height;
	} Size;
	struct {
		size_t minx, maxx, miny, maxy;
	} Corner; // as integer

	Corner.maxx = (size_t)_max_x;
	Corner.maxy = (size_t)_max_y;
	
	Corner.minx = (size_t)_min_x;
	Corner.miny = (size_t)_min_y;

	if(reverseIdx & ae2f_eBmpSrcCpyPrm_RVSE_I_X) {
		Corner.minx = xleft - Corner.minx;
		Corner.maxx = xleft - Corner.maxx;

		if(Corner.minx) Corner.minx--;
		if(Corner.maxx) Corner.maxx--;

		Corner.maxx ^= Corner.minx; 
		Corner.minx ^= Corner.maxx; 
		Corner.maxx ^= Corner.minx; 
	}

	if(reverseIdx & ae2f_eBmpSrcCpyPrm_RVSE_I_Y) {
		Corner.miny = yleft - Corner.miny;
		Corner.maxy = yleft - Corner.maxy;

		if(Corner.miny) Corner.miny--;
		if(Corner.maxy) Corner.maxy--;

		Corner.maxy ^= Corner.miny;
		Corner.miny ^= Corner.maxy;
		Corner.maxy ^= Corner.miny;
	}

	if(Corner.minx == Corner.maxx)
	Corner.maxx++;

	if(Corner.miny == Corner.maxy)
	Corner.maxy++;

	#pragma region Centre
	for(size_t i = Corner.minx; i < Corner.maxx; i++)
	for(size_t j = Corner.miny; j < Corner.maxy; j++) {
		const ae2f_ptrBmpSrcUInt8 const __src = src->Addr + ae2f_BmpIdxDrive(src->rIdxer, i, j) * (src->ElSize >> 3);

		// invalid index check
		// index validation
		if(__src + 1 == src->Addr) continue;

		switch(src->ElSize) {
			case ae2f_eBmpBitCount_RGB: {
				Channel.R += __src[0];
				Channel.G += __src[1];
				Channel.B += __src[2];
				Channel.Count += 1;
			} break;

			case ae2f_eBmpBitCount_RGBA: {
				Channel.R += __src[0] * __src[3];
				Channel.G += __src[1] * __src[3];
				Channel.B += __src[2] * __src[3];
				Channel.A += __src[3];
				Channel.Count += __src[3];
			} break;
		}
	}
	#pragma endregion

	switch(src->ElSize) {
		case ae2f_eBmpBitCount_RGBA: {
			retColour[0] = 
			ae2f_BmpDotRGBAMk(
				Channel.R / Channel.Count, 
				Channel.G / Channel.Count,
				Channel.B / Channel.Count,
				Channel.A / Channel.Count
			);
		} break;
		case ae2f_eBmpBitCount_RGB: {
			retColour[0] = 
			ae2f_BmpDotRGBAMk(
				Channel.R / Channel.Count,
				Channel.G / Channel.Count,
				Channel.B / Channel.Count,
				255
			);
		} break;
	}
	return ae2f_errGlob_OK;
}



__kernel void ae2f_BmpCLKernFill(
    __global ae2f_struct ae2f_cBmpSrc* desthead,
    union __colour colour
) {
	const uint32_t wi = get_global_id(0), hi = get_global_id(1);
    const uint8_t ws = get_global_size(2), wsi = get_global_id(2);

    switch(ws) {
        case 3: case 4: break;
        default: return;
    }

	const uint32_t idx = (ae2f_BmpIdxDrive(desthead->rIdxer, wi, hi));
	if(idx == ((uint32_t)-1)) return;

    desthead->Addr[(idx * ws) + wsi] = colour.b[wsi];
}

__kernel void ae2f_BmpCLKernCpy(
    __global ae2f_struct ae2f_cBmpSrc* dest,
    __global ae2f_struct ae2f_cBmpSrc* src,
    ae2f_struct ae2f_cBmpSrcCpyPrm prm
) {
	#define srcprm prm
	ae2f_err_t code;

    const uint32_t ws = get_global_size(2);
    const uint32_t x = get_global_id(0), y = get_global_id(1);
    const uint32_t k = get_global_id(2);

	if (!(src && dest && src->Addr && dest->Addr)) {
		return;
	}

	// check if all alpha is zero
	if (!srcprm.Alpha && src->ElSize != ae2f_eBmpBitCount_RGBA)
		return;

	switch (ws) {
	case ae2f_eBmpBitCount_RGB >> 3:
	case ae2f_eBmpBitCount_RGBA >> 3: break;
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

    code = __ae2f_cBmpSrcGDot(
        src, &el.a, 
        dotw * _x, 
        doth * _y, 
        dotw * (_x + 1), 
        doth * (_y+1),
        prm.ReverseIdx
    );

	const ae2f_float_t
	__cos = cos(prm.RotateXYCounterClockWise),
	__sin = sin(prm.RotateXYCounterClockWise);
	

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
    rotatedX = _transx * __cos + _transy * __sin + prm.AxisX,
    rotatedY = _transy * __cos - _transx * __sin + prm.AxisY;

    #pragma region single dot
    uint32_t foridx = 
    ae2f_BmpIdxDrive(
        dest->rIdxer, 
		(int32_t)rotatedX + prm.AddrXForDest, 
		(int32_t)rotatedY + prm.AddrYForDest
	);
    
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