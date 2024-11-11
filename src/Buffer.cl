#define ae2f_Macro_Cmp_TakeGt(a, b)		((a) > (b) ? (a) : (b))
#define ae2f_Macro_Cmp_TakeLs(a, b)	((a) < (b) ? (a) : (b))
#define ae2f_Macro_Cmp_Diff(a, b)			(ae2f_Macro_Cmp_TakeGt(a, b) - ae2f_Macro_Cmp_TakeLs(a, b))
#define ae2f_Macro_Cmp_TakeMem(ptr, member, alter) ((ptr) ? ((ptr)->member) : (alter))
#define ae2f_Macro_Cmp_TakeSelf(ptr, alt) ((ptr) ? (ptr) : (alt))

#define _ae2f_Macro_BitVec_Filled(len, vec_t) ae2f_static_cast(vec_t, (sizeof(vec_t) << 3) == (len) ? ae2f_static_cast(vec_t, -1) : (ae2f_static_cast(vec_t, ae2f_static_cast(vec_t, 1) << (len)) - 1))
#define ae2f_Macro_BitVec_Filled(len) _ae2f_Macro_BitVec_Filled(len, size_t)
#define _ae2f_Macro_BitVec_GetRanged(vector, start, end, vec_t) (((vector) >> (start)) & _ae2f_Macro_BitVec_Filled((end) - (start), vec_t))
#define ae2f_Macro_BitVec_GetRanged(vector, start, end) _ae2f_Macro_BitVec_GetRanged(vector, ae2f_Macro_Cmp_TakeLs(start, end), ae2f_Macro_Cmp_TakeGt(start, end), size_t)
#define ae2f_Macro_BitVec_Get(vector, idx) ae2f_Macro_BitVec_GetRanged(vector, idx, (idx) + 1)
#define _ae2f_Macro_BitVec_SetRanged(vector, start, end, val, vec_t) ((vector) & (~((_ae2f_Macro_BitVec_Filled((end) - (start), vec_t)) << start)) | ((val) << start))
#define ae2f_Macro_BitVec_SetRanged(vector, start, end, val) _ae2f_Macro_BitVec_SetRanged(vector, ae2f_Macro_Cmp_TakeLs(start, end), ae2f_Macro_Cmp_TakeGt(start, end), (val) & ae2f_Macro_BitVec_Filled(ae2f_Macro_Cmp_Diff(start, end)), size_t)
#define ae2f_Macro_BitVec_Set(vector, idx, val) ae2f_Macro_BitVec_SetRanged(vector, idx, (idx) + 1, val)

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

ae2f_errint_t _gDot(
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

void _Fill_Partial(
	ae2f_struct ae2f_Bmp_cSrc* dest,
	uint32_t colour,

	uint32_t partial_min_x,
	uint32_t partial_min_y,
	uint32_t partial_max_x,
	uint32_t partial_max_y
) {
	if(!dest)
	return;

	switch (dest->ElSize) {
	case ae2f_Bmp_Idxer_eBC_RGB:
	case ae2f_Bmp_Idxer_eBC_RGBA: break;
	default: return;
	}

	uint32_t width = ae2f_Bmp_Idx_XLeft(dest->rIdxer), height = ae2f_Bmp_Idx_YLeft(dest->rIdxer);

	for(size_t i = partial_min_x; i < width && i < partial_max_x; i++)	
	for(size_t j = partial_min_y; j < height && j < partial_max_y; j++)
	for(uint8_t c = 0; c < dest->ElSize; c+=8)
		ae2f_Bmp_cSrc_Addr(dest, uint8*)[(ae2f_Bmp_Idx_Drive(dest->rIdxer, i, j)) * (dest->ElSize >> 3) + (c >> 3)] = ae2f_Macro_BitVec_GetRanged(colour, c, c+8);

	return;
}


__kernel void Fill(
	__global ae2f_struct ae2f_Bmp_cSrc* dest,
	uint32_t colour,

	uint32_t partial_min_x,
	uint32_t partial_min_y,
	uint32_t partial_max_x,
	uint32_t partial_max_y,

	uint32_t segcount
) {
	size_t segi = get_global_id(0);
	uint32_t 
		width = ae2f_Bmp_Idx_XLeft(dest->rIdxer),
		height = ae2f_Bmp_Idx_YLeft(dest->rIdxer);
	
	if(!segcount && segcount == 1) return;

	if(!partial_max_x) partial_max_x = width;
	if(!partial_max_y) partial_max_y = height;

	if(partial_max_x <= partial_min_x) return;
	if(partial_max_y <= partial_min_y) return;

	width = partial_max_x - partial_min_x;
	uint32_t segw = width / (segcount - 1);
	uint32_t rest = width - (segw * (segcount - 1));

	if(segi + 1 == segcount) 
	return _Fill_Partial(dest, colour, partial_max_x - rest, partial_min_y, partial_max_x, partial_max_y);
	else 
	return _Fill_Partial(dest, colour, partial_min_x + segw * segi, partial_min_y, partial_min_x + segw * segi + segw, partial_max_y);
}