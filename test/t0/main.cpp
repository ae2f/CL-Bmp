#include <iostream>
#include <CL/cl.h>

#pragma region __source

const char* __SOURCE = R"(
#define ae2f_Bmp_Dot_RGBA_GetR(rgb) ae2f_static_cast(uchar, ae2f_Macro_BitVec_GetRanged(ae2f_static_cast(uint, rgb), 0, 8))
#define ae2f_Bmp_Dot_RGBA_GetG(rgb) ae2f_static_cast(uchar, ae2f_Macro_BitVec_GetRanged(ae2f_static_cast(uint, rgb), 8, 16))
#define ae2f_Bmp_Dot_RGBA_GetB(rgb) ae2f_static_cast(uchar, ae2f_Macro_BitVec_GetRanged(ae2f_static_cast(uint, rgb), 16, 24))
#define ae2f_Bmp_Dot_RGBA_GetA(rgba) ae2f_static_cast(uchar, ae2f_Macro_BitVec_GetRanged(ae2f_static_cast(uint, rgba), 24, 32))

#define ae2f_Bmp_Dot_RGBA_SetR(rgb, val)  ae2f_static_cast(uint, ae2f_Macro_BitVec_SetRanged(ae2f_static_cast(uint, rgb), 0, 8, val))
#define ae2f_Bmp_Dot_RGBA_SetG(rgb, val)  ae2f_static_cast(uint, ae2f_Macro_BitVec_SetRanged(ae2f_static_cast(uint, rgb), 8, 16, val))
#define ae2f_Bmp_Dot_RGBA_SetB(rgb, val)  ae2f_static_cast(uint, ae2f_Macro_BitVec_SetRanged(ae2f_static_cast(uint, rgb), 16, 24, val))
#define ae2f_Bmp_Dot_RGBA_SetA(rgba, val) ae2f_static_cast(uint, ae2f_Macro_BitVec_SetRanged(ae2f_static_cast(uint, rgba), 24, 32, val))

#define ae2f_Bmp_Dot_RGB_Make(r, g, b) ae2f_static_cast(uint, ae2f_static_cast(uchar, r) | (ae2f_static_cast(ushort, g) << 8) | (ae2f_static_cast(uint, b) << 16))
#define ae2f_Bmp_Dot_RGBA_Make(r, g, b, a) ae2f_static_cast(uint, ae2f_static_cast(uchar, r) | (ae2f_static_cast(ushort, g) << 8) | (ae2f_static_cast(uint, b) << 16) | (ae2f_static_cast(uint, a) << 24))
#define ae2f_Bmp_Dot_RGBA_FromRGB(rgb, a) ae2f_Bmp_Dot_RGBA_SetA(rgb, a)

#define ae2f_Bmp_Dot_Blend_imp(a, b, ratio_a, rtn_t, prefixForOperatee) ae2f_static_cast(rtn_t, (((a) * (ratio_a) + (b) * (1.0##prefixForOperatee - (ratio_a)))))

#define ae2f_Bmp_Dot_rRGBA_Blend_mRGB(rgba1, rgba2, iRGB, pfOper) ae2f_Bmp_Dot_Blend_imp(ae2f_Bmp_Dot_RGBA_Get##iRGB(rgba1), ae2f_Bmp_Dot_RGBA_Get##iRGB(rgba2), ae2f_Bmp_Dot_RGBA_GetA(rgba1) / (ae2f_static_cast(ae2f_Bmp_Dot_Blender_t##pfOper, ae2f_Bmp_Dot_RGBA_GetA(rgba1)) + ae2f_Bmp_Dot_RGBA_GetA(rgba2)), uchar, pfOper)
#define ae2f_Bmp_Dot_rRGBA_Blend_mpRGB(rgb, rgba, iRGB, pfOper) ae2f_Bmp_Dot_Blend_imp(ae2f_Bmp_Dot_RGBA_Get##iRGB(rgba), ae2f_Bmp_Dot_RGBA_Get##iRGB(rgb), ae2f_Bmp_Dot_RGBA_GetA(rgba) / 255.0##pfOper, uchar, pfOper)
#define ae2f_Bmp_Dot_rRGBA_BlendA(rgba1, rgba2, pfOper) ae2f_Bmp_Dot_Blend_imp(ae2f_Bmp_Dot_RGBA_GetA(rgba1), ae2f_Bmp_Dot_RGBA_GetB(rgba2), 0.5##pfOper, ae2f_Bmp_Dot_Blender_t##pfOper, pfOper)

#define ae2f_Bmp_Dot_rRGBA_BlendRGB(rgb, rgba, pfOper) ae2f_Bmp_Dot_RGB_Make(ae2f_Bmp_Dot_rRGBA_Blend_mpRGB(rgba, rgba, R, pfOper), ae2f_Bmp_Dot_rRGBA_Blend_mpRGB(rgba, rgba, G, pfOper), ae2f_Bmp_Dot_rRGBA_Blend_mpRGB(rgba, rgba, B, pfOper))
#define ae2f_Bmp_Dot_rRGBA_BlendRGBA(rgba1, rgba2, pfOper) ae2f_Bmp_Dot_RGBA_Make(ae2f_Bmp_Dot_rRGBA_Blend_mRGB(rgba1, rgba2, R, pfOper), ae2f_Bmp_Dot_rRGBA_Blend_mRGB(rgba1, rgba2, G, pfOper), ae2f_Bmp_Dot_rRGBA_Blend_mRGB(rgba1, rgba2, B, pfOper), ae2f_Bmp_Dot_rRGBA_BlendA(rgba1, rgba2, pfOper))

typedef uchar ae2f_errint_t, ae2f_Bmp_Idxer_eBC_t, uint8_t;
#define uint32_t uint
#define ae2f_struct struct

struct ae2f_Bmp_rIdxer {
	uint32_t Width, Count, CurrX, IdxXJump;
};

// test
#define ae2f_static_cast(t, v) ((t)(v))
#define ae2f_record_make(type, ...) ((type) { __VA_ARGS__ })

struct ae2f_Bmp_cSrc {
	struct ae2f_Bmp_rIdxer rIdxer;
	ae2f_Bmp_Idxer_eBC_t ElSize;
};

#define ae2f_Bmp_cSrc_Addr(src, type) ae2f_static_cast(type, (src + 1))

#define ae2f_Bmp_Idx_XLeft(rIdxer) ((rIdxer).IdxXJump - (rIdxer).CurrX)
#define ae2f_Bmp_Idx_YLeft(rIdxer) ((rIdxer).Count / (rIdxer).Width)
#define __ae2f_Bmp_Idx_DriveX(rIdxer, dx) ae2f_static_cast(uint32_t, (dx) < ae2f_Bmp_Idx_XLeft(rIdxer) ? (dx) : -1)
#define __ae2f_Bmp_Idx_DriveY(rIdxer, dy) ae2f_static_cast(uint32_t, (dy) < ae2f_Bmp_Idx_YLeft(rIdxer) ? (dy) : -1)
#define ae2f_Bmp_Idx_Drive(rIdxer, dx, dy) ae2f_static_cast(uint32_t, __ae2f_Bmp_Idx_DriveX(rIdxer, dx) == ae2f_static_cast(uint32_t, -1) ? -1 : __ae2f_Bmp_Idx_DriveY(rIdxer, dy) == ae2f_static_cast(uint32_t, -1) ? -1 : __ae2f_Bmp_Idx_DriveX(rIdxer, dx) + __ae2f_Bmp_Idx_DriveY(rIdxer, dy) * (rIdxer).Width)
#define ae2f_Bmp_Idx_Cut(rIdxer, mX, MX, mY, MY) (((ae2f_Bmp_Idx_Drive(rIdxer, mX, mY) == -1 || ae2f_Bmp_Idx_Drive(rIdxer, MX, MY)) == -1) ? ae2f_record_make(ae2f_struct ae2f_Bmp_rIdxer, 0, 0, 0, 0) : ae2f_record_make(ae2f_struct ae2f_Bmp_rIdxer, (rIdxer).Width, ae2f_Bmp_Idx_Drive(rIdxer, MX, MY), (rIdxer).CurrX + mX, (rIdxer).CurrX + MX))

// The Operation you've wanted has beed succeed. 
#define ae2f_errGlob_OK ae2f_static_cast(ae2f_errint_t, 0)

// Failed to find the function on preprocessor which is callable for some reason
// No operation has beed done.
#define ae2f_errGlob_IMP_NOT_FOUND ae2f_static_cast(ae2f_errint_t, 0b1)

// Failed to refer the pointer either l-value inside the function.
#define ae2f_errGlob_PTR_IS_NULL ae2f_static_cast(ae2f_errint_t, 0b10)

// Failed freeing the memory.
#define ae2f_errGlob_FLUSH_FAILED ae2f_static_cast(ae2f_errint_t, 0b100)

// stdlib allocating functions (malloc, calloc, realloc) has been failed.
#define ae2f_errGlob_ALLOC_FAILED ae2f_static_cast(ae2f_errint_t, 0b1000)

// Found that parameter sent by programmer is invalid.
// The operation may have been ceased while the middle.
#define ae2f_errGlob_WRONG_OPERATION ae2f_static_cast(ae2f_errint_t, 0b10000)

// Found some errors, but not by parameters.
// The operation has failed.
#define ae2f_errGlob_NFOUND ae2f_static_cast(ae2f_errint_t, 0b100000)

// The operation went done.
// Note that operation may not be valid.
#define ae2f_errGlob_DONE_HOWEV ae2f_static_cast(ae2f_errint_t, 0b1000000)

// Enum about Bit Count per Pixel
enum ae2f_Bmp_Idxer_eBC {
	ae2f_Bmp_Idxer_eBC_BIT = 1,
	ae2f_Bmp_Idxer_eBC_HALF = 4, // 0 ~ 15
	ae2f_Bmp_Idxer_eBC_BYTE = 8, // 0 ~ 255
	ae2f_Bmp_Idxer_eBC_RGB = 24, // not indexing, rgb
	ae2f_Bmp_Idxer_eBC_RGBA = 32, // not indexing, rgba
	ae2f_Bmp_Idxer_eBC_REMINDER_OWNER = 64
};

#define ae2f_Bmp_cSrc_Copy_Global_Alpha_ReverseIdxOfX ae2f_static_cast(uint8_t, 	0b01)
#define ae2f_Bmp_cSrc_Copy_Global_Alpha_ReverseIdxOfY ae2f_static_cast(uint8_t, 	0b10)

ae2f_errint_t ae2f_Bmp_cSrc_gDot(
	const ae2f_struct ae2f_Bmp_cSrc* src,
	uint32_t* retColour,
	double* __rect,
	uint8_t reverseIdx
) {
	#define _min_x __rect[0]
	#define _min_y __rect[1]
	#define _max_x __rect[2]
	#define _max_y __rect[3]

	const uint32_t 
	xleft = ae2f_Bmp_Idx_XLeft(src->rIdxer), 
	yleft = ae2f_Bmp_Idx_YLeft(src->rIdxer);

	if(!(src && retColour && ae2f_Bmp_cSrc_Addr(src, uint8*)))
	return ae2f_errGlob_PTR_IS_NULL;

	struct {
		double R, G, B, A, Count;
	} Channel = {0, 0, 0, 0, 0};

	switch(src->ElSize) {
		case ae2f_Bmp_Idxer_eBC_RGB:
		case ae2f_Bmp_Idxer_eBC_RGBA:
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

	if(reverseIdx & ae2f_Bmp_cSrc_Copy_Global_Alpha_ReverseIdxOfX) {
		Corner.minx = xleft - Corner.minx;
		Corner.maxx = xleft - Corner.maxx;

		if(Corner.minx) Corner.minx--;
		if(Corner.maxx) Corner.maxx--;

		Corner.maxx ^= Corner.minx; 
		Corner.minx ^= Corner.maxx; 
		Corner.maxx ^= Corner.minx; 
	}

	if(reverseIdx & ae2f_Bmp_cSrc_Copy_Global_Alpha_ReverseIdxOfY) {
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
		const uint8_t* const __src = ae2f_Bmp_cSrc_Addr(src, const uint8_t*) + ae2f_Bmp_Idx_Drive(src->rIdxer, i, j) * (src->ElSize >> 3);

		// invalid index check
		// index validation
		if(__src + 1 == ae2f_Bmp_cSrc_Addr(src, const uint8_t*)) continue;

		switch(src->ElSize) {
			case ae2f_Bmp_Idxer_eBC_RGB: {
				Channel.R += __src[0];
				Channel.G += __src[1];
				Channel.B += __src[2];
				Channel.Count += 1;
			} break;

			case ae2f_Bmp_Idxer_eBC_RGBA: {
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
		case ae2f_Bmp_Idxer_eBC_RGBA: {
			retColour[0] = 
			ae2f_Bmp_Dot_RGBA_Make(
				Channel.R / Channel.Count, 
				Channel.G / Channel.Count,
				Channel.B / Channel.Count,
				Channel.A / Channel.Count
			);
		} break;
		case ae2f_Bmp_Idxer_eBC_RGB: {
			retColour[0] = 
			ae2f_Bmp_Dot_RGBA_Make(
				Channel.R / Channel.Count,
				Channel.G / Channel.Count,
				Channel.B / Channel.Count,
				255
			);
		} break;
	}
	return ae2f_errGlob_OK;
}

#undef _min_x
#undef _min_y
#undef _max_x
#undef _max_y
)";

#pragma endregion

#define CHECK_ERR() if (err != CL_SUCCESS) { goto __failure; }

int main() {
    cl_int err = 0;
    cl_platform_id platform = 0;
    cl_device_id device = 0;
    cl_context context = 0;
    cl_program program = 0;

    err = clGetPlatformIDs(1, &platform, 0);
    CHECK_ERR();

    
    err = clGetDeviceIDs(platform, CL_DEVICE_TYPE_GPU, 1, &device, 0);
    CHECK_ERR();

    context = clCreateContext(0, 1, &device, 0, 0, &err);
    CHECK_ERR();

    program = clCreateProgramWithSource(
        context, 1, &__SOURCE, 0, &err
    );
    CHECK_ERR();

    printf("Operation went successful.\n");

    if (program) clReleaseProgram(program);
    if (context) clReleaseContext(context);
    return 0;

    __failure:
    if (program) clReleaseProgram(program);
    if (context) clReleaseContext(context);
    fprintf(stderr, "Error: %d\n", err);
    return 1;
}