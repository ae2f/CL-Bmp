typedef uint uint32_t;
typedef ushort uint16_t;
typedef uchar uint8_t;
typedef int int32_t;

#define global m_global
#if !defined(ae2f_Bmp_Src_h)
#define ae2f_Bmp_Src_h

#if !defined(ae2f_Bmp_Idxer_h)
#define ae2f_Bmp_Idxer_h

/// @file
/// Those numbers with [ @ref ae2f_err_t ] will be the state.

#if !defined(ae2f_errGlobal_h)
#define ae2f_errGlobal_h


/// @brief
/// Informs that this number represents the error.
typedef uint8_t ae2f_err_t;

/// @brief
/// The Operation you've wanted went successful. 
#define ae2f_errGlob_OK 0

/// @brief
/// Failed to find the function on preprocessor which is callable for some reason
/// No operation has beed done.
#define ae2f_errGlob_IMP_NOT_FOUND 0b1

/// @brief
/// Failed to refer the pointer either l-value inside the function.
#define ae2f_errGlob_PTR_IS_NULL 0b10

/// @brief
/// Failed freeing the memory.
#define ae2f_errGlob_FLUSH_FAILED 0b100

/// @brief
/// stdlib allocating functions (malloc, calloc, realloc) has been failed.
#define ae2f_errGlob_ALLOC_FAILED 0b1000

/// @brief
/// Found that parameter sent by programmer is invalid.
/// The operation may have been ceased while the middle.
#define ae2f_errGlob_WRONG_OPERATION 0b10000

/// @brief
/// Found some errors, but not by parameters.
/// The operation has failed.
#define ae2f_errGlob_NFOUND 0b100000

/// @brief
/// The operation went done.
/// Note that operation may not be valid.
#define ae2f_errGlob_DONE_HOWEV 0b1000000

#endif

#if !defined(ae2f_Cmp_h)
#define ae2f_Cmp_h

/// @warning
/// Two parameters must be comparable with operator.
/// @return
/// One bigger.
#define ae2f_Cmp_TakeGt(a, b)		((a) > (b) ? (a) : (b))

/// @warning
/// Two parameters must be comparable with operator.
/// @return
/// One smaller.
#define ae2f_Cmp_TakeLs(a, b)	((a) < (b) ? (a) : (b))

/// @return
/// The absolute different of two.
#define ae2f_Cmp_Diff(a, b)			(ae2f_Cmp_TakeGt(a, b) - ae2f_Cmp_TakeLs(a, b))

/// @brief
/// Gets the member from the pointer.
/// Given nullptr, the return will be alter.
/// @param ptr The pointer for getting member.
/// @param member The valid member's name. [from the structure]
/// @param alter The alternative value when given nullptr.
#define ae2f_Cmp_TakeMem(ptr, member, alter) ((ptr) ? ((ptr)->member) : (alter))

/// @brief
/// Returns ptr's self.
/// Given nullptr, the return will be alt.
/// @param ptr Self Referring
/// @param alt The alternative value.
#define ae2f_Cmp_TakeSelf(ptr, alt) ((ptr) ? (ptr) : (alt))
#endif // !defined(ae2f_Macro_Compare_h)

#if !defined(ae2f_Macro_Cast_h)

/// @brief
/// asdf
#define ae2f_Macro_Cast_h

/// @brief
/// ANSI Code for clearing the console.
/// Clearing all display, moving the cursor on the top.
#define ae2f_Cast_CCls "\033[2J\033[H"

/// @brief
/// simply merge all text inside the round bracket, counting them as a single text block.
#define ae2f_Cast_Merge(...) __VA_ARGS__


#if defined(__cplusplus)

#if !defined(ae2f_Cast_CasterUnion_hpp)
#define ae2f_Cast_CasterUnion_hpp

/// @brief 
/// C++ union definition for @ref ae2f_union_cast
/// @tparam t 
/// @tparam k 
/// @see
/// @ref ae2f_union_cast
template<typename t, typename k>
union ae2f_union_caster {
	t a;
	k b;
};

#endif


/// @brief
/// Appears when the current language is C++.
#define ae2f_add_when_cxx(...) __VA_ARGS__

/// @brief
/// Appears when the current language is C.
#define ae2f_add_when_c(...)

#else

/// @brief
/// Appears when the current language is C++.
#define ae2f_add_when_cxx(...)

/// @brief
/// Appears when the current language is C.
#define ae2f_add_when_c(...) __VA_ARGS__

#endif // defined(__cplusplus)

/// @brief
/// Initialiser for trivial structures / classes.
#define ae2f_record_make(type, ...) (ae2f_add_when_c((type) { __VA_ARGS__ }) ae2f_add_when_cxx(type{ __VA_ARGS__ }))

/// @brief
/// # static_cast
#define ae2f_static_cast(t, v) ae2f_add_when_c(((t)(v))) ae2f_add_when_cxx(static_cast<t>(v))

/// @brief
/// # dynamic_cast
#define ae2f_dynamic_cast(t, v) ae2f_add_when_c(((t)(v))) ae2f_add_when_cxx(dynamic_cast<t>(v))

/// @brief
/// # reinterpret_cast
#define ae2f_reinterpret_cast(t, v) ae2f_add_when_c(((t)(v))) ae2f_add_when_cxx(reinterpret_cast<t>(v))

/// @brief
/// # const_cast
#define ae2f_const_cast(t, v) ae2f_add_when_c(((t)(v))) ae2f_add_when_cxx(const_cast<t>(v))

/// @brief
/// Makes a union that reads a memory in two methods. \n
/// `tThen` -> `tNow`
/// @tparam tThen
/// The existing data's type as input.
/// 
/// @tparam tNow
/// Wanted output datatype for casting.
///
/// @param v
/// Input value
#define ae2f_union_cast(tThen, tNow, v) ae2f_add_when_c((union { tThen a; tNow b; }) { v }) ae2f_add_when_cxx(ae2f_union_caster<tThen, tNow>{ v }) .b

/// @brief
/// In C, keyword 'struct' must be written in front of the structure's name in order to use as a type name. \n
/// In C++ that keyword is not required.
/// 
/// This keyword resolves the difference of the rules of two.
#define ae2f_struct ae2f_add_when_c(struct)

/// @brief
/// Suggests the existence of external variable or function, in naming of C. [non-mangling]
#define ae2f_extern ae2f_add_when_c(extern) ae2f_add_when_cxx(extern "C")

/// @brief
/// Class 
#define ae2f_class ae2f_add_when_c(struct) ae2f_add_when_cxx(class)

/// @brief
/// Makes the global variable in naming of C. [non-mangling]
#define ae2f_var ae2f_add_when_cxx(extern "C")

/// @brief
/// Function definitions
#define ae2f_fdef(rtn_t, name, ...) rtn_t (*name)(__VA_ARGS__)

#endif


#if 0
#pragma pack(push, 0)
#endif


/// @brief
/// Suggest array as matrix.
/// @warning 
/// Certain structure has no responsibility for considering size of each elements. 
struct ae2f_rBmpIdx {
	uint32_t 
		/// @brief Actually considered width [Global width]
		Width, 

		/// @brief The actual element count [Local Count]
		Count,

		/// @brief Describe the current position as X where an address points. [Local X start]
		CurrX,

		/// @brief Suggested width [Local Width]
		IdxXJump;
};

#if 0
#pragma pack(pop)
#endif


/// @brief An actual Width of the @ref ae2f_rBmpIdx.
#define ae2f_BmpIdxW(rIdxer) ((rIdxer).IdxXJump - (rIdxer).CurrX)

/// @brief An actual Height of the @ref ae2f_rBmpIdx.
#define ae2f_BmpIdxH(rIdxer) ((rIdxer).Count / (rIdxer).Width)

/// @warning
/// Direct use of this macro is not recommended.
/// @see ae2f_BmpIdxDrive
#define ae2f_BmpIdxDriveX_imp(rIdxer, dx) ae2f_static_cast(uint32_t, (dx) < ae2f_BmpIdxW(rIdxer) ? (dx) : -1)

/// @warning
/// Direct use of this macro is not recommended.
/// @see ae2f_BmpIdxDrive
#define ae2f_BmpIdxDriveY_imp(rIdxer, dy) ae2f_static_cast(uint32_t, (dy) < ae2f_BmpIdxH(rIdxer) ? (dy) : -1)

/// @brief
/// The result index is not valid.
/// @see ae2f_BmpIdxDrive
#define ae2f_eBmpIdxDrive_BAD_IDX ae2f_static_cast(uint32_t, -1)

/// @brief
/// Calculates the linear index based on info from [rIdxer].
/// @param rIdxer { @ref ae2f_rBmpIdx }
/// @param dx { uint32_t } Distance as x
/// @param dy { uint32_t } Distance as y
/// @return {uint32_t} \n
/// The actual index for linear memory.
/// @exception \
/// @ref ae2f_eBmpIdxDrive_BAD_IDX
#define ae2f_BmpIdxDrive(rIdxer, dx, dy) ae2f_static_cast(uint32_t, ae2f_BmpIdxDriveX_imp(rIdxer, dx) == ae2f_static_cast(uint32_t, -1) ? -1 : ae2f_BmpIdxDriveY_imp(rIdxer, dy) == ae2f_static_cast(uint32_t, -1) ? -1 : ae2f_BmpIdxDriveX_imp(rIdxer, dx) + ae2f_BmpIdxDriveY_imp(rIdxer, dy) * (rIdxer).Width)

/// @warning
/// Certain macro is not certified.
/// @todo 
/// Add a test for it
/// @brief
/// Makes a new structure with original indexer.
/// @see ae2f_rBmpIdx
#define ae2f_BmpIdxCut(rIdxer, mX, MX, mY, MY) (((ae2f_BmpIdxDrive(rIdxer, mX, mY) == -1 || ae2f_BmpIdxDrive(rIdxer, MX, MY)) == -1) ? ae2f_record_make(ae2f_struct ae2f_rBmpIdx, 0, 0, 0, 0) : ae2f_record_make(ae2f_struct ae2f_rBmpIdx, (rIdxer).Width, ae2f_BmpIdxDrive(rIdxer, MX, MY), (rIdxer).CurrX + mX, (rIdxer).CurrX + MX))

#endif

#define ON 1
#define OFF 0

#if (defined(_WIN32) || defined(_WIN64))
#define ae2f_IS_WIN 1
#else 
#define ae2f_IS_WIN 0
#endif 

#define ae2f_IS_SHARED OFF

#if (defined(__linux__))
#define ae2f_IS_LINUX 1
#else 
#define ae2f_IS_LINUX 0
#endif
#if ae2f_IS_SHARED

#if ae2f_IS_WIN == ae2f_IS_LINUX
#error This library will not work gracefully under this OS, which means it has no clue for this lib.
#endif

#if ae2f_IS_WIN
/// @brief
/// # For Windows
/// 
/// shared function imp
#define ae2f_SHAREDEXPORT __declspec(dllexport)

/// @brief
/// # For Windows
/// 
/// Function api call
#define ae2f_SHAREDCALL
#else
/// @brief
/// # For Linux, gcc based.
/// 
/// shared function imp
#define ae2f_SHAREDEXPORT __attribute__((visibility("default")))

/// @brief
/// # For Linux, gcc based.
///
/// Function api call
#define ae2f_SHAREDCALL
#endif
#else

/// @brief
/// # It is no shared library.
/// 
/// shared function imp
#define ae2f_SHAREDEXPORT
/// @brief 
/// # It is no shared library.
///
/// Function api call
#define ae2f_SHAREDCALL
#endif

#ifndef ae2f_float_h
#define ae2f_float_h

typedef float ae2f_float_t;

#endif 

#ifndef ae2f_Bmp_BitCount_h
#define ae2f_Bmp_BitCount_h


/// @brief
/// Enum about Bit Count per Pixel
enum ae2f_eBmpBitCount {
	/// @brief 0 | 1
	ae2f_eBmpBitCount_BIT = 1,

	/// @brief 0 ~ 15
	ae2f_eBmpBitCount_HALF = 4,

	/// @brief 0 ~ 255 
	ae2f_eBmpBitCount_BYTE = 8,

	/// @brief not indexing, rgb
	ae2f_eBmpBitCount_RGB = 24, 

	/// @brief not indexing, rgba
	ae2f_eBmpBitCount_RGBA = 32,

	/// @brief Something is wrong
	ae2f_eBmpBitCount_REMINDER_OWNER = 64
};

/// @brief 
typedef uint8_t ae2f_eBmpBitCount_t;

#endif

#if 0
#pragma pack(push, 0)
#endif



/// @brief 
/// A global parameter for @ref ae2f_cBmpSrcCpy.
struct ae2f_cBmpSrcCpyPrm {
	uint8_t 
		/// @brief
		/// Global Alpha for RGB architect.
		Alpha,
		/// @brief
		/// For reversed copy.
		ReverseIdx;
	uint32_t 
		/// @brief want to resize?
		WidthAsResized, 
		/// @brief want to resize?
		HeightAsResized, 	
		/// @brief where to copy [X]
		AddrXForDest, 		
		/// @brief where to copy [Y]
		AddrYForDest, 		
		DataToIgnore;

	
	/// @brief Rotation in a unit of radian
	ae2f_float_t RotateXYCounterClockWise;

	int32_t 
		/// @brief
		/// The position of rotation Axis [X]
		AxisX, 
		/// @brief
		/// The position of rotation Axis [Y]
		AxisY;
};

/// @brief
/// @ref ae2f_cBmpSrcCpyPrm::ReverseIdx
#define ae2f_eBmpSrcCpyPrm_RVSE_I_X ae2f_static_cast(uint8_t, 	0b01)

/// @brief
/// @ref ae2f_cBmpSrcCpyPrm::ReverseIdx
#define ae2f_eBmpSrcCpyPrm_RVSE_I_Y ae2f_static_cast(uint8_t, 	0b10)

/// @brief
/// Contains additional the colour values for indexed bmp.
/// @param len Length of the colour index.
/// @see ae2f_cBmpSrcCpyPrm
#define ae2f_cBmpSrcCpyPrmDef(len) struct ae2f_cBmpSrcCpyPrmDef_i##len { ae2f_struct ae2f_cBmpSrcCpyPrm global; uint32_t ColourIdx[len]; }

/// @brief 
/// Represents the source of the bitmap. \n 
/// This structure has no responsibility for a memory.
struct ae2f_cBmpSrc {
	/// @brief
	/// Indexing suporter
	/// Abstraction
	ae2f_struct ae2f_rBmpIdx rIdxer;

	/// @brief
	/// size of each element[pixel] as bit
	/// bit cound [Element Size]
	ae2f_eBmpBitCount_t ElSize;

	/// @brief
	/// Real element[pixel] vector [Global]
	uint8_t* Addr;
};

/// @brief 
/// Fills the colour for whole range in [dest].
/// @param dest 
/// The target memory.
/// @param colour
/// The colour value to fill. 
/// @return 
/// @ref ae2f_errGlob_OK
/// @exception \ 
/// @ref ae2f_errGlob_PTR_IS_NULL \n 
/// @ref ae2f_errGlob_IMP_NOT_FOUND
ae2f_extern ae2f_SHAREDCALL ae2f_err_t ae2f_cBmpSrcFill(
	ae2f_struct ae2f_cBmpSrc* dest,
	uint32_t colour
);

/// @brief 
/// Fills the colour for whole range in [dest].
/// @param dest 
/// The target memory.
/// @param colour
/// The colour value to fill. 
/// @param partial_min_x 
/// for Rect
/// @param partial_min_y 
/// for Rect
/// @param partial_max_x 
/// for Rect
/// @param partial_max_y
/// for Rect 
/// @return @ref ae2f_errGlob_OK
/// @exception \
/// @ref ae2f_errGlob_PTR_IS_NULL \n
/// @ref ae2f_errGlob_IMP_NOT_FOUND
ae2f_extern ae2f_SHAREDCALL ae2f_err_t ae2f_cBmpSrcFillPartial(
	ae2f_struct ae2f_cBmpSrc* dest,
	uint32_t colour,

	uint32_t partial_min_x,
	uint32_t partial_min_y,
	uint32_t partial_max_x,
	uint32_t partial_max_y
);

/// @brief 
/// Gets the 3-channel or 4-channel value for given rect.
/// @param src 
/// @param retColour
/// Address where the value stored. 
/// @param _min_x 
/// for Rect
/// @param _min_y
/// for Rect
/// @param _max_x
/// for Rect
/// @param _max_y
/// for Rect
/// @param reverseIdx
/// To consider reversing index when iterating.
/// @return 
/// @ref ae2f_errGlob_OK
/// @exception \ 
/// @ref ae2f_errGlob_IMP_NOT_FOUND \n
/// @ref ae2f_errGlob_PTR_IS_NULL
/// @see @ref ae2f_eBmpSrcCpyPrm_RVSE_I_X
/// @see @ref ae2f_eBmpSrcCpyPrm_RVSE_I_Y
ae2f_extern ae2f_SHAREDCALL ae2f_err_t ae2f_cBmpSrcGDot(
	const ae2f_struct ae2f_cBmpSrc* src,
	uint32_t* retColour,
	ae2f_float_t _min_x,
	ae2f_float_t _min_y,
	ae2f_float_t _max_x,
	ae2f_float_t _max_y,

	uint8_t reverseIdx
);

/// @brief 
/// Copies the data of [src] to [dest]. \n
/// [src] will be considered that is has only 3 channels in use, aka RGB.
/// @param dest 
/// Destination where the [src] would be copied. \n
/// Allocating will not be automatically done.
/// @param src 
/// Source which has the actual data.
/// @param srcprm 
/// Additional operator attribute for [src].
/// @return
/// @ref ae2f_errGlob_OK
/// @exception \
/// @ref ae2f_errGlob_PTR_IS_NULL \n 
/// @ref ae2f_errGlob_IMP_NOT_FOUND 
ae2f_extern ae2f_SHAREDCALL ae2f_err_t ae2f_cBmpSrcCpy(
	ae2f_struct ae2f_cBmpSrc* dest,
	const ae2f_struct ae2f_cBmpSrc* src,
	const ae2f_struct ae2f_cBmpSrcCpyPrm* srcprm
);

/// @brief 
/// Copies the data of [src] to [dest]. \n
/// [src] will be considered that is has only 3 channels in use, aka RGB.
/// @param dest 
/// Destination where the [src] would be copied. \n
/// Allocating will not be automatically done.
/// @param src 
/// Source which has the actual data.
/// @param srcprm 
/// Additional operator attribute for [src].
/// @return @ref ae2f_errGlob_OK
/// @exception \
/// @ref ae2f_errGlob_PTR_IS_NULL \n 
/// @ref ae2f_errGlob_IMP_NOT_FOUND
ae2f_extern ae2f_SHAREDCALL ae2f_err_t ae2f_cBmpSrcCpyPartial(
	ae2f_struct ae2f_cBmpSrc* dest,
	const ae2f_struct ae2f_cBmpSrc* src,
	const ae2f_struct ae2f_cBmpSrcCpyPrm* srcprm,
	uint32_t partial_min_x,
	uint32_t partial_min_y,
	uint32_t partial_max_x,
	uint32_t partial_max_y
);

/// @brief 
/// `byte` is not long enough to parse.
#define ae2f_errBmpSrcRef_ARR_TOO_SHORT ae2f_errGlob_WRONG_OPERATION

/// @brief 
/// # After this operation [dest] will still not own the memory, but [byte] will.
/// @param dest 
/// Destination where the [byte] 
/// @param byte 
/// The data of bmp structure with header.
/// @param byteLength 
/// size of the [byte].
/// @return 
ae2f_extern ae2f_SHAREDCALL ae2f_err_t ae2f_cBmpSrcRef(
	ae2f_struct ae2f_cBmpSrc* dest,
	uint8_t* byte,
	size_t byteLength
);

/// @warning
/// Certain Macro is not certified.
#define ae2f_cBmpSrcCut(cSrc, mX, MX, mY, MY) ae2f_record_make(ae2f_struct ae2f_cBmpSrc, ae2f_BmpIdxCut((cSrc).rIdxer, mX, MX, mY, MX), (cSrc).ElSize, (cSrc).Addr + ae2f_BmpIdxDrive((cSrc).rIdxer, mX, mY) * (cSrc).ElSize)

#if 0
#pragma pack(pop)
#endif


#endif

#if !defined(ae2f_Cmp_h)
#define ae2f_Cmp_h

/// @warning
/// Two parameters must be comparable with operator.
/// @return
/// One bigger.
#define ae2f_Cmp_TakeGt(a, b)		((a) > (b) ? (a) : (b))

/// @warning
/// Two parameters must be comparable with operator.
/// @return
/// One smaller.
#define ae2f_Cmp_TakeLs(a, b)	((a) < (b) ? (a) : (b))

/// @return
/// The absolute different of two.
#define ae2f_Cmp_Diff(a, b)			(ae2f_Cmp_TakeGt(a, b) - ae2f_Cmp_TakeLs(a, b))

/// @brief
/// Gets the member from the pointer.
/// Given nullptr, the return will be alter.
/// @param ptr The pointer for getting member.
/// @param member The valid member's name. [from the structure]
/// @param alter The alternative value when given nullptr.
#define ae2f_Cmp_TakeMem(ptr, member, alter) ((ptr) ? ((ptr)->member) : (alter))

/// @brief
/// Returns ptr's self.
/// Given nullptr, the return will be alt.
/// @param ptr Self Referring
/// @param alt The alternative value.
#define ae2f_Cmp_TakeSelf(ptr, alt) ((ptr) ? (ptr) : (alt))
#endif // !defined(ae2f_Macro_Compare_h)

#if !defined(ae2f_Bmp_Dot_h)

#pragma region dot_h_def
#define ae2f_Bmp_Dot_h

#pragma endregion

#if !defined(ae2f_Macro_Cast_h)

/// @brief
/// asdf
#define ae2f_Macro_Cast_h

/// @brief
/// ANSI Code for clearing the console.
/// Clearing all display, moving the cursor on the top.
#define ae2f_Cast_CCls "\033[2J\033[H"

/// @brief
/// simply merge all text inside the round bracket, counting them as a single text block.
#define ae2f_Cast_Merge(...) __VA_ARGS__


#if defined(__cplusplus)

#if !defined(ae2f_Cast_CasterUnion_hpp)
#define ae2f_Cast_CasterUnion_hpp

/// @brief 
/// C++ union definition for @ref ae2f_union_cast
/// @tparam t 
/// @tparam k 
/// @see
/// @ref ae2f_union_cast
template<typename t, typename k>
union ae2f_union_caster {
	t a;
	k b;
};

#endif


/// @brief
/// Appears when the current language is C++.
#define ae2f_add_when_cxx(...) __VA_ARGS__

/// @brief
/// Appears when the current language is C.
#define ae2f_add_when_c(...)

#else

/// @brief
/// Appears when the current language is C++.
#define ae2f_add_when_cxx(...)

/// @brief
/// Appears when the current language is C.
#define ae2f_add_when_c(...) __VA_ARGS__

#endif // defined(__cplusplus)

/// @brief
/// Initialiser for trivial structures / classes.
#define ae2f_record_make(type, ...) (ae2f_add_when_c((type) { __VA_ARGS__ }) ae2f_add_when_cxx(type{ __VA_ARGS__ }))

/// @brief
/// # static_cast
#define ae2f_static_cast(t, v) ae2f_add_when_c(((t)(v))) ae2f_add_when_cxx(static_cast<t>(v))

/// @brief
/// # dynamic_cast
#define ae2f_dynamic_cast(t, v) ae2f_add_when_c(((t)(v))) ae2f_add_when_cxx(dynamic_cast<t>(v))

/// @brief
/// # reinterpret_cast
#define ae2f_reinterpret_cast(t, v) ae2f_add_when_c(((t)(v))) ae2f_add_when_cxx(reinterpret_cast<t>(v))

/// @brief
/// # const_cast
#define ae2f_const_cast(t, v) ae2f_add_when_c(((t)(v))) ae2f_add_when_cxx(const_cast<t>(v))

/// @brief
/// Makes a union that reads a memory in two methods. \n
/// `tThen` -> `tNow`
/// @tparam tThen
/// The existing data's type as input.
/// 
/// @tparam tNow
/// Wanted output datatype for casting.
///
/// @param v
/// Input value
#define ae2f_union_cast(tThen, tNow, v) ae2f_add_when_c((union { tThen a; tNow b; }) { v }) ae2f_add_when_cxx(ae2f_union_caster<tThen, tNow>{ v }) .b

/// @brief
/// In C, keyword 'struct' must be written in front of the structure's name in order to use as a type name. \n
/// In C++ that keyword is not required.
/// 
/// This keyword resolves the difference of the rules of two.
#define ae2f_struct ae2f_add_when_c(struct)

/// @brief
/// Suggests the existence of external variable or function, in naming of C. [non-mangling]
#define ae2f_extern ae2f_add_when_c(extern) ae2f_add_when_cxx(extern "C")

/// @brief
/// Class 
#define ae2f_class ae2f_add_when_c(struct) ae2f_add_when_cxx(class)

/// @brief
/// Makes the global variable in naming of C. [non-mangling]
#define ae2f_var ae2f_add_when_cxx(extern "C")

/// @brief
/// Function definitions
#define ae2f_fdef(rtn_t, name, ...) rtn_t (*name)(__VA_ARGS__)

#endif

#if !defined(ae2f_BitVec_h)
#define ae2f_BitVec_h

#if !defined(ae2f_Macro_Cast_h)

/// @brief
/// asdf
#define ae2f_Macro_Cast_h

/// @brief
/// ANSI Code for clearing the console.
/// Clearing all display, moving the cursor on the top.
#define ae2f_Cast_CCls "\033[2J\033[H"

/// @brief
/// simply merge all text inside the round bracket, counting them as a single text block.
#define ae2f_Cast_Merge(...) __VA_ARGS__


#if defined(__cplusplus)

#if !defined(ae2f_Cast_CasterUnion_hpp)
#define ae2f_Cast_CasterUnion_hpp

/// @brief 
/// C++ union definition for @ref ae2f_union_cast
/// @tparam t 
/// @tparam k 
/// @see
/// @ref ae2f_union_cast
template<typename t, typename k>
union ae2f_union_caster {
	t a;
	k b;
};

#endif


/// @brief
/// Appears when the current language is C++.
#define ae2f_add_when_cxx(...) __VA_ARGS__

/// @brief
/// Appears when the current language is C.
#define ae2f_add_when_c(...)

#else

/// @brief
/// Appears when the current language is C++.
#define ae2f_add_when_cxx(...)

/// @brief
/// Appears when the current language is C.
#define ae2f_add_when_c(...) __VA_ARGS__

#endif // defined(__cplusplus)

/// @brief
/// Initialiser for trivial structures / classes.
#define ae2f_record_make(type, ...) (ae2f_add_when_c((type) { __VA_ARGS__ }) ae2f_add_when_cxx(type{ __VA_ARGS__ }))

/// @brief
/// # static_cast
#define ae2f_static_cast(t, v) ae2f_add_when_c(((t)(v))) ae2f_add_when_cxx(static_cast<t>(v))

/// @brief
/// # dynamic_cast
#define ae2f_dynamic_cast(t, v) ae2f_add_when_c(((t)(v))) ae2f_add_when_cxx(dynamic_cast<t>(v))

/// @brief
/// # reinterpret_cast
#define ae2f_reinterpret_cast(t, v) ae2f_add_when_c(((t)(v))) ae2f_add_when_cxx(reinterpret_cast<t>(v))

/// @brief
/// # const_cast
#define ae2f_const_cast(t, v) ae2f_add_when_c(((t)(v))) ae2f_add_when_cxx(const_cast<t>(v))

/// @brief
/// Makes a union that reads a memory in two methods. \n
/// `tThen` -> `tNow`
/// @tparam tThen
/// The existing data's type as input.
/// 
/// @tparam tNow
/// Wanted output datatype for casting.
///
/// @param v
/// Input value
#define ae2f_union_cast(tThen, tNow, v) ae2f_add_when_c((union { tThen a; tNow b; }) { v }) ae2f_add_when_cxx(ae2f_union_caster<tThen, tNow>{ v }) .b

/// @brief
/// In C, keyword 'struct' must be written in front of the structure's name in order to use as a type name. \n
/// In C++ that keyword is not required.
/// 
/// This keyword resolves the difference of the rules of two.
#define ae2f_struct ae2f_add_when_c(struct)

/// @brief
/// Suggests the existence of external variable or function, in naming of C. [non-mangling]
#define ae2f_extern ae2f_add_when_c(extern) ae2f_add_when_cxx(extern "C")

/// @brief
/// Class 
#define ae2f_class ae2f_add_when_c(struct) ae2f_add_when_cxx(class)

/// @brief
/// Makes the global variable in naming of C. [non-mangling]
#define ae2f_var ae2f_add_when_cxx(extern "C")

/// @brief
/// Function definitions
#define ae2f_fdef(rtn_t, name, ...) rtn_t (*name)(__VA_ARGS__)

#endif

#if !defined(ae2f_Cmp_h)
#define ae2f_Cmp_h

/// @warning
/// Two parameters must be comparable with operator.
/// @return
/// One bigger.
#define ae2f_Cmp_TakeGt(a, b)		((a) > (b) ? (a) : (b))

/// @warning
/// Two parameters must be comparable with operator.
/// @return
/// One smaller.
#define ae2f_Cmp_TakeLs(a, b)	((a) < (b) ? (a) : (b))

/// @return
/// The absolute different of two.
#define ae2f_Cmp_Diff(a, b)			(ae2f_Cmp_TakeGt(a, b) - ae2f_Cmp_TakeLs(a, b))

/// @brief
/// Gets the member from the pointer.
/// Given nullptr, the return will be alter.
/// @param ptr The pointer for getting member.
/// @param member The valid member's name. [from the structure]
/// @param alter The alternative value when given nullptr.
#define ae2f_Cmp_TakeMem(ptr, member, alter) ((ptr) ? ((ptr)->member) : (alter))

/// @brief
/// Returns ptr's self.
/// Given nullptr, the return will be alt.
/// @param ptr Self Referring
/// @param alt The alternative value.
#define ae2f_Cmp_TakeSelf(ptr, alt) ((ptr) ? (ptr) : (alt))
#endif // !defined(ae2f_Macro_Compare_h)


/// @brief 
/// The pre-defined index type for Bit vector.
typedef uint8_t ae2f_BitVecI_t;

/// @brief Generates the vector filled in `1`.
/// @param len The length of the filled vector.
/// @tparam vec_t The integer data type.
#define _ae2f_BitVec_Filled(len, vec_t) ae2f_static_cast(vec_t, (sizeof(vec_t) << 3) == (len) ? ae2f_static_cast(vec_t, -1) : (ae2f_static_cast(vec_t, ae2f_static_cast(vec_t, 1) << (len)) - 1))

/// @brief Generates the vector filled in `1`.
/// @param len {ae2f_Macro_BitVecI_t} The length of the filled vector.
#define ae2f_BitVec_Filled(len) _ae2f_BitVec_Filled(len, size_t)

/// @brief
/// Gets the bits of [vector] between index of [start] and [end].
/// @param vector {vec_t} The target for operation.
/// @param start {ae2f_Macro_BitVecI_t} The starting index.
/// @param end {ae2f_Macro_BitVecI_t} The ending index.
/// @tparam vec_t The integer data type.
/// @warning
/// [start] greater than [end] may cause undefined behaviour.
#define _ae2f_BitVec_GetRanged(vector, start, end, vec_t) (((vector) >> (start)) & _ae2f_BitVec_Filled((end) - (start), vec_t))

/// @brief
/// Gets the bits of [vector] between index of [start] and [end]. \n
/// It will normalise the values of [start] and [end] by switching them.
/// @param vector {size_t} The target for operation.
/// @param start {ae2f_Macro_BitVecI_t} The starting index.
/// @param end {ae2f_Macro_BitVecI_t} The ending index.
/// @see _ae2f_Macro_BitVec_GetRanged
#define ae2f_BitVec_GetRanged(vector, start, end) _ae2f_BitVec_GetRanged(vector, ae2f_Cmp_TakeLs(start, end), ae2f_Cmp_TakeGt(start, end), size_t)

/// @brief
/// Gets a bit of [vector] from index of [idx].
/// @param vector {size_t} The target for operation.
/// @param idx {ae2f_Macro_BitVecI_t} The wanted index for searching.
/// @see ae2f_Macro_BitVec_GetRanged
#define ae2f_BitVec_Get(vector, idx) ae2f_BitVec_GetRanged(vector, idx, (idx) + 1)

/// @brief
/// Sets the bits of [vector] from index of [start] and [end] by [val].
/// @param vector {vec_t} The target for operation.
/// @param start {ae2f_Macro_BitVecI_t} The starting index.
/// @param end {ae2f_Macro_BitVecI_t} The ending index.
/// @param val {vec_t} The value to set.
/// @tparam vec_t The integer data type.
/// @warning
/// [start] greater than [end] may cause undefined behaviour.
#define _ae2f_BitVec_SetRanged(vector, start, end, val, vec_t) ((vector) & (~((_ae2f_BitVec_Filled((end) - (start), vec_t)) << start)) | ((val) << start))

/// @brief
/// Sets the bits of [vector] from index of [start] and [end] by [val]. \n
/// It will normalise the values of [start] and [end] by switching them.
/// @param vector {vec_t} The target for operation.
/// @param start {ae2f_Macro_BitVecI_t} The starting index.
/// @param end {ae2f_Macro_BitVecI_t} The ending index.
/// @param val {size_t} The value to set.
#define ae2f_BitVec_SetRanged(vector, start, end, val) _ae2f_BitVec_SetRanged(vector, ae2f_Cmp_TakeLs(start, end), ae2f_Cmp_TakeGt(start, end), (val) & ae2f_BitVec_Filled(ae2f_Cmp_Diff(start, end)), size_t)

/// @brief
/// Sets a bit of [vector] from index of [idx] by [val].
/// @param vector {size_t} The target for operation.
/// @param idx {bool} The wanted index for searching.
/// @see ae2f_Macro_BitVec_GetRanged
#define ae2f_BitVec_Set(vector, idx, val) ae2f_BitVec_SetRanged(vector, idx, (idx) + 1, val)

#endif // !defined(ae2f_Macro_BitVector_h)

#ifndef ae2f_float_h
#define ae2f_float_h

typedef float ae2f_float_t;

#endif 


/// @brief 
/// 32 - byte which means has four channels of [r, g, b, a].
typedef uint32_t ae2f_Bmp_Dot_rgba_t;

#pragma region RGBA get-set

/// @brief
/// Gets the value of channel [R]
/// @param rgb {uint32_t} 
/// 3-channel colour integer.
#define ae2f_BmpDotRGBAGetR(rgb) ae2f_static_cast(uint8_t, ae2f_BitVec_GetRanged(ae2f_static_cast(uint32_t, rgb), 0, 8))

/// @brief
/// Gets the value of channel [G]
/// @param rgb {uint32_t} 3-channel colour integer.
#define ae2f_BmpDotRGBAGetG(rgb) ae2f_static_cast(uint8_t, ae2f_BitVec_GetRanged(ae2f_static_cast(uint32_t, rgb), 8, 16))

/// @brief
/// Gets the value of channel [B]
/// @param rgb {uint32_t} 3-channel colour integer.
#define ae2f_BmpDotRGBAGetB(rgb) ae2f_static_cast(uint8_t, ae2f_BitVec_GetRanged(ae2f_static_cast(uint32_t, rgb), 16, 24))

/// @brief
/// Gets the value of channel [A]
/// @param rgba {uint32_t} 4-channel colour integer.
#define ae2f_BmpDotRGBAGetA(rgba) ae2f_static_cast(uint8_t, ae2f_BitVec_GetRanged(ae2f_static_cast(uint32_t, rgba), 24, 32))

/// @brief
/// Sets the value of channel [R]
/// @param rgb {uint32_t}
/// @param val The value to set
#define ae2f_BmpDotRGBASetR(rgb, val)  ae2f_static_cast(uint32_t, ae2f_BitVec_SetRanged(ae2f_static_cast(uint32_t, rgb), 0, 8, val))

/// @brief
/// Sets the value of channel [G]
/// @param rgb {uint32_t}
/// @param val The value to set
#define ae2f_BmpDotRGBASetG(rgb, val)  ae2f_static_cast(uint32_t, ae2f_BitVec_SetRanged(ae2f_static_cast(uint32_t, rgb), 8, 16, val))

/// @brief
/// Sets the value of channel [B]
/// @param rgb {uint32_t}
/// @param val The value to set
#define ae2f_BmpDotRGBASetB(rgb, val)  ae2f_static_cast(uint32_t, ae2f_BitVec_SetRanged(ae2f_static_cast(uint32_t, rgb), 16, 24, val))

/// @brief
/// Sets the value of channel [A]
/// @param rgba {uint32_t}
/// @param val The value to set
#define ae2f_BmpDotRGBASetA(rgba, val) ae2f_static_cast(uint32_t, ae2f_BitVec_SetRanged(ae2f_static_cast(uint32_t, rgba), 24, 32, val))

/// @brief
/// Generates a new number with three channels configured(initialised).
/// @param r 
/// Initial Value for channel [R]
/// @param g 
/// Initial Value for channel [G]
/// @param b 
/// Initial Value for channel [B]
/// @return {uint32_t} 3-channel colour integer.
#define ae2f_BmpDotRGBMk(r, g, b) ae2f_static_cast(uint32_t, ae2f_static_cast(uint8_t, r) | (ae2f_static_cast(uint16_t, g) << 8) | (ae2f_static_cast(uint32_t, b) << 16))

/// @brief
/// Generates a new number with four channels configured(initialised).
/// @param r 
/// Initial Value for channel [R]
/// @param g 
/// Initial Value for channel [G]
/// @param b 
/// Initial Value for channel [B]
/// @param a
/// Initial Value for channel [A]
/// @return {uint32_t} 4-channel colour integer.
#define ae2f_BmpDotRGBAMk(r, g, b, a) ae2f_static_cast(uint32_t, ae2f_static_cast(uint8_t, r) | (ae2f_static_cast(uint16_t, g) << 8) | (ae2f_static_cast(uint32_t, b) << 16) | (ae2f_static_cast(uint32_t, a) << 24))


/// @brief
/// Generates a new number with seed of [RGB] and initialising value for channel [A].
/// @param rgb
/// Seed RGB Channels
/// @param a
/// Initial value for Channel [A]
/// @return {uint32_t}
#define ae2f_BmpDotRGBMkA(rgb, a) ae2f_BmpDotRGBASetA(rgb, a)

#pragma endregion

#endif

#if !defined(ae2f_BitVec_h)
#define ae2f_BitVec_h

#if !defined(ae2f_Macro_Cast_h)

/// @brief
/// asdf
#define ae2f_Macro_Cast_h

/// @brief
/// ANSI Code for clearing the console.
/// Clearing all display, moving the cursor on the top.
#define ae2f_Cast_CCls "\033[2J\033[H"

/// @brief
/// simply merge all text inside the round bracket, counting them as a single text block.
#define ae2f_Cast_Merge(...) __VA_ARGS__


#if defined(__cplusplus)

#if !defined(ae2f_Cast_CasterUnion_hpp)
#define ae2f_Cast_CasterUnion_hpp

/// @brief 
/// C++ union definition for @ref ae2f_union_cast
/// @tparam t 
/// @tparam k 
/// @see
/// @ref ae2f_union_cast
template<typename t, typename k>
union ae2f_union_caster {
	t a;
	k b;
};

#endif


/// @brief
/// Appears when the current language is C++.
#define ae2f_add_when_cxx(...) __VA_ARGS__

/// @brief
/// Appears when the current language is C.
#define ae2f_add_when_c(...)

#else

/// @brief
/// Appears when the current language is C++.
#define ae2f_add_when_cxx(...)

/// @brief
/// Appears when the current language is C.
#define ae2f_add_when_c(...) __VA_ARGS__

#endif // defined(__cplusplus)

/// @brief
/// Initialiser for trivial structures / classes.
#define ae2f_record_make(type, ...) (ae2f_add_when_c((type) { __VA_ARGS__ }) ae2f_add_when_cxx(type{ __VA_ARGS__ }))

/// @brief
/// # static_cast
#define ae2f_static_cast(t, v) ae2f_add_when_c(((t)(v))) ae2f_add_when_cxx(static_cast<t>(v))

/// @brief
/// # dynamic_cast
#define ae2f_dynamic_cast(t, v) ae2f_add_when_c(((t)(v))) ae2f_add_when_cxx(dynamic_cast<t>(v))

/// @brief
/// # reinterpret_cast
#define ae2f_reinterpret_cast(t, v) ae2f_add_when_c(((t)(v))) ae2f_add_when_cxx(reinterpret_cast<t>(v))

/// @brief
/// # const_cast
#define ae2f_const_cast(t, v) ae2f_add_when_c(((t)(v))) ae2f_add_when_cxx(const_cast<t>(v))

/// @brief
/// Makes a union that reads a memory in two methods. \n
/// `tThen` -> `tNow`
/// @tparam tThen
/// The existing data's type as input.
/// 
/// @tparam tNow
/// Wanted output datatype for casting.
///
/// @param v
/// Input value
#define ae2f_union_cast(tThen, tNow, v) ae2f_add_when_c((union { tThen a; tNow b; }) { v }) ae2f_add_when_cxx(ae2f_union_caster<tThen, tNow>{ v }) .b

/// @brief
/// In C, keyword 'struct' must be written in front of the structure's name in order to use as a type name. \n
/// In C++ that keyword is not required.
/// 
/// This keyword resolves the difference of the rules of two.
#define ae2f_struct ae2f_add_when_c(struct)

/// @brief
/// Suggests the existence of external variable or function, in naming of C. [non-mangling]
#define ae2f_extern ae2f_add_when_c(extern) ae2f_add_when_cxx(extern "C")

/// @brief
/// Class 
#define ae2f_class ae2f_add_when_c(struct) ae2f_add_when_cxx(class)

/// @brief
/// Makes the global variable in naming of C. [non-mangling]
#define ae2f_var ae2f_add_when_cxx(extern "C")

/// @brief
/// Function definitions
#define ae2f_fdef(rtn_t, name, ...) rtn_t (*name)(__VA_ARGS__)

#endif

#if !defined(ae2f_Cmp_h)
#define ae2f_Cmp_h

/// @warning
/// Two parameters must be comparable with operator.
/// @return
/// One bigger.
#define ae2f_Cmp_TakeGt(a, b)		((a) > (b) ? (a) : (b))

/// @warning
/// Two parameters must be comparable with operator.
/// @return
/// One smaller.
#define ae2f_Cmp_TakeLs(a, b)	((a) < (b) ? (a) : (b))

/// @return
/// The absolute different of two.
#define ae2f_Cmp_Diff(a, b)			(ae2f_Cmp_TakeGt(a, b) - ae2f_Cmp_TakeLs(a, b))

/// @brief
/// Gets the member from the pointer.
/// Given nullptr, the return will be alter.
/// @param ptr The pointer for getting member.
/// @param member The valid member's name. [from the structure]
/// @param alter The alternative value when given nullptr.
#define ae2f_Cmp_TakeMem(ptr, member, alter) ((ptr) ? ((ptr)->member) : (alter))

/// @brief
/// Returns ptr's self.
/// Given nullptr, the return will be alt.
/// @param ptr Self Referring
/// @param alt The alternative value.
#define ae2f_Cmp_TakeSelf(ptr, alt) ((ptr) ? (ptr) : (alt))
#endif // !defined(ae2f_Macro_Compare_h)


/// @brief 
/// The pre-defined index type for Bit vector.
typedef uint8_t ae2f_BitVecI_t;

/// @brief Generates the vector filled in `1`.
/// @param len The length of the filled vector.
/// @tparam vec_t The integer data type.
#define _ae2f_BitVec_Filled(len, vec_t) ae2f_static_cast(vec_t, (sizeof(vec_t) << 3) == (len) ? ae2f_static_cast(vec_t, -1) : (ae2f_static_cast(vec_t, ae2f_static_cast(vec_t, 1) << (len)) - 1))

/// @brief Generates the vector filled in `1`.
/// @param len {ae2f_Macro_BitVecI_t} The length of the filled vector.
#define ae2f_BitVec_Filled(len) _ae2f_BitVec_Filled(len, size_t)

/// @brief
/// Gets the bits of [vector] between index of [start] and [end].
/// @param vector {vec_t} The target for operation.
/// @param start {ae2f_Macro_BitVecI_t} The starting index.
/// @param end {ae2f_Macro_BitVecI_t} The ending index.
/// @tparam vec_t The integer data type.
/// @warning
/// [start] greater than [end] may cause undefined behaviour.
#define _ae2f_BitVec_GetRanged(vector, start, end, vec_t) (((vector) >> (start)) & _ae2f_BitVec_Filled((end) - (start), vec_t))

/// @brief
/// Gets the bits of [vector] between index of [start] and [end]. \n
/// It will normalise the values of [start] and [end] by switching them.
/// @param vector {size_t} The target for operation.
/// @param start {ae2f_Macro_BitVecI_t} The starting index.
/// @param end {ae2f_Macro_BitVecI_t} The ending index.
/// @see _ae2f_Macro_BitVec_GetRanged
#define ae2f_BitVec_GetRanged(vector, start, end) _ae2f_BitVec_GetRanged(vector, ae2f_Cmp_TakeLs(start, end), ae2f_Cmp_TakeGt(start, end), size_t)

/// @brief
/// Gets a bit of [vector] from index of [idx].
/// @param vector {size_t} The target for operation.
/// @param idx {ae2f_Macro_BitVecI_t} The wanted index for searching.
/// @see ae2f_Macro_BitVec_GetRanged
#define ae2f_BitVec_Get(vector, idx) ae2f_BitVec_GetRanged(vector, idx, (idx) + 1)

/// @brief
/// Sets the bits of [vector] from index of [start] and [end] by [val].
/// @param vector {vec_t} The target for operation.
/// @param start {ae2f_Macro_BitVecI_t} The starting index.
/// @param end {ae2f_Macro_BitVecI_t} The ending index.
/// @param val {vec_t} The value to set.
/// @tparam vec_t The integer data type.
/// @warning
/// [start] greater than [end] may cause undefined behaviour.
#define _ae2f_BitVec_SetRanged(vector, start, end, val, vec_t) ((vector) & (~((_ae2f_BitVec_Filled((end) - (start), vec_t)) << start)) | ((val) << start))

/// @brief
/// Sets the bits of [vector] from index of [start] and [end] by [val]. \n
/// It will normalise the values of [start] and [end] by switching them.
/// @param vector {vec_t} The target for operation.
/// @param start {ae2f_Macro_BitVecI_t} The starting index.
/// @param end {ae2f_Macro_BitVecI_t} The ending index.
/// @param val {size_t} The value to set.
#define ae2f_BitVec_SetRanged(vector, start, end, val) _ae2f_BitVec_SetRanged(vector, ae2f_Cmp_TakeLs(start, end), ae2f_Cmp_TakeGt(start, end), (val) & ae2f_BitVec_Filled(ae2f_Cmp_Diff(start, end)), size_t)

/// @brief
/// Sets a bit of [vector] from index of [idx] by [val].
/// @param vector {size_t} The target for operation.
/// @param idx {bool} The wanted index for searching.
/// @see ae2f_Macro_BitVec_GetRanged
#define ae2f_BitVec_Set(vector, idx, val) ae2f_BitVec_SetRanged(vector, idx, (idx) + 1, val)

#endif // !defined(ae2f_Macro_BitVector_h)

#if !defined(ae2f_Bmp_Head_h)
#define ae2f_Bmp_Head_h

#if !defined(ae2f_Macro_Cast_h)

/// @brief
/// asdf
#define ae2f_Macro_Cast_h

/// @brief
/// ANSI Code for clearing the console.
/// Clearing all display, moving the cursor on the top.
#define ae2f_Cast_CCls "\033[2J\033[H"

/// @brief
/// simply merge all text inside the round bracket, counting them as a single text block.
#define ae2f_Cast_Merge(...) __VA_ARGS__


#if defined(__cplusplus)

#if !defined(ae2f_Cast_CasterUnion_hpp)
#define ae2f_Cast_CasterUnion_hpp

/// @brief 
/// C++ union definition for @ref ae2f_union_cast
/// @tparam t 
/// @tparam k 
/// @see
/// @ref ae2f_union_cast
template<typename t, typename k>
union ae2f_union_caster {
	t a;
	k b;
};

#endif


/// @brief
/// Appears when the current language is C++.
#define ae2f_add_when_cxx(...) __VA_ARGS__

/// @brief
/// Appears when the current language is C.
#define ae2f_add_when_c(...)

#else

/// @brief
/// Appears when the current language is C++.
#define ae2f_add_when_cxx(...)

/// @brief
/// Appears when the current language is C.
#define ae2f_add_when_c(...) __VA_ARGS__

#endif // defined(__cplusplus)

/// @brief
/// Initialiser for trivial structures / classes.
#define ae2f_record_make(type, ...) (ae2f_add_when_c((type) { __VA_ARGS__ }) ae2f_add_when_cxx(type{ __VA_ARGS__ }))

/// @brief
/// # static_cast
#define ae2f_static_cast(t, v) ae2f_add_when_c(((t)(v))) ae2f_add_when_cxx(static_cast<t>(v))

/// @brief
/// # dynamic_cast
#define ae2f_dynamic_cast(t, v) ae2f_add_when_c(((t)(v))) ae2f_add_when_cxx(dynamic_cast<t>(v))

/// @brief
/// # reinterpret_cast
#define ae2f_reinterpret_cast(t, v) ae2f_add_when_c(((t)(v))) ae2f_add_when_cxx(reinterpret_cast<t>(v))

/// @brief
/// # const_cast
#define ae2f_const_cast(t, v) ae2f_add_when_c(((t)(v))) ae2f_add_when_cxx(const_cast<t>(v))

/// @brief
/// Makes a union that reads a memory in two methods. \n
/// `tThen` -> `tNow`
/// @tparam tThen
/// The existing data's type as input.
/// 
/// @tparam tNow
/// Wanted output datatype for casting.
///
/// @param v
/// Input value
#define ae2f_union_cast(tThen, tNow, v) ae2f_add_when_c((union { tThen a; tNow b; }) { v }) ae2f_add_when_cxx(ae2f_union_caster<tThen, tNow>{ v }) .b

/// @brief
/// In C, keyword 'struct' must be written in front of the structure's name in order to use as a type name. \n
/// In C++ that keyword is not required.
/// 
/// This keyword resolves the difference of the rules of two.
#define ae2f_struct ae2f_add_when_c(struct)

/// @brief
/// Suggests the existence of external variable or function, in naming of C. [non-mangling]
#define ae2f_extern ae2f_add_when_c(extern) ae2f_add_when_cxx(extern "C")

/// @brief
/// Class 
#define ae2f_class ae2f_add_when_c(struct) ae2f_add_when_cxx(class)

/// @brief
/// Makes the global variable in naming of C. [non-mangling]
#define ae2f_var ae2f_add_when_cxx(extern "C")

/// @brief
/// Function definitions
#define ae2f_fdef(rtn_t, name, ...) rtn_t (*name)(__VA_ARGS__)

#endif


#pragma pack(push, 1) 

/// @brief
/// Pre-defined [B]itmap [F]ile header [BF]
struct ae2f_rBmpHeadBF {
    uint16_t bfType;
    uint32_t bfSize;
    uint16_t bfReserved1; // unless 0 would be fucked up
    uint16_t bfReserved2; // unless 0 would be fucked up
    uint32_t bfOffBits;
};

/// @brief
/// [B]itmap [I]nfo Header [BI]
struct ae2f_rBmpHeadBI {
    /// @brief
    /// Actual size
    uint32_t biSize;

    /// @brief
    /// Unit as pixel count
    int32_t  biWidth;

    /// @brief
    /// Height as pixel count
    int32_t  biHeight;

    
    uint16_t biPlanes;        // unless 1 would be fucked up

    /// @brief
    /// The size of each elements.
    uint16_t biBitCount;      // among { 1, 4, 8, 24, 32 }
    uint32_t biCompression;
    uint32_t biSizeImage;     // unit: Byte
    int32_t  biXPelsPerMeter;
    int32_t  biYPelsPerMeter;
    uint32_t biClrUsed;
    uint32_t biClrImportant;
};


/// @brief 
/// Bitmap header suggested.
struct ae2f_rBmpHead {
    ae2f_struct ae2f_rBmpHeadBF rBF;
    ae2f_struct ae2f_rBmpHeadBI rBI;
};


#pragma pack(pop)
#endif

#define ON 1
#define OFF 0

#if (defined(_WIN32) || defined(_WIN64))
#define ae2f_IS_WIN 1
#else 
#define ae2f_IS_WIN 0
#endif 

#define ae2f_IS_SHARED OFF

#if (defined(__linux__))
#define ae2f_IS_LINUX 1
#else 
#define ae2f_IS_LINUX 0
#endif
#if ae2f_IS_SHARED

#if ae2f_IS_WIN == ae2f_IS_LINUX
#error This library will not work gracefully under this OS, which means it has no clue for this lib.
#endif

#if ae2f_IS_WIN
/// @brief
/// # For Windows
/// 
/// shared function imp
#define ae2f_SHAREDEXPORT __declspec(dllexport)

/// @brief
/// # For Windows
/// 
/// Function api call
#define ae2f_SHAREDCALL
#else
/// @brief
/// # For Linux, gcc based.
/// 
/// shared function imp
#define ae2f_SHAREDEXPORT __attribute__((visibility("default")))

/// @brief
/// # For Linux, gcc based.
///
/// Function api call
#define ae2f_SHAREDCALL
#endif
#else

/// @brief
/// # It is no shared library.
/// 
/// shared function imp
#define ae2f_SHAREDEXPORT
/// @brief 
/// # It is no shared library.
///
/// Function api call
#define ae2f_SHAREDCALL
#endif

#ifndef ae2f_Bmp_Blend_h
#define ae2f_Bmp_Blend_h

#if !defined(ae2f_Bmp_Dot_h)

#pragma region dot_h_def
#define ae2f_Bmp_Dot_h

#pragma endregion

#if !defined(ae2f_Macro_Cast_h)

/// @brief
/// asdf
#define ae2f_Macro_Cast_h

/// @brief
/// ANSI Code for clearing the console.
/// Clearing all display, moving the cursor on the top.
#define ae2f_Cast_CCls "\033[2J\033[H"

/// @brief
/// simply merge all text inside the round bracket, counting them as a single text block.
#define ae2f_Cast_Merge(...) __VA_ARGS__


#if defined(__cplusplus)

#if !defined(ae2f_Cast_CasterUnion_hpp)
#define ae2f_Cast_CasterUnion_hpp

/// @brief 
/// C++ union definition for @ref ae2f_union_cast
/// @tparam t 
/// @tparam k 
/// @see
/// @ref ae2f_union_cast
template<typename t, typename k>
union ae2f_union_caster {
	t a;
	k b;
};

#endif


/// @brief
/// Appears when the current language is C++.
#define ae2f_add_when_cxx(...) __VA_ARGS__

/// @brief
/// Appears when the current language is C.
#define ae2f_add_when_c(...)

#else

/// @brief
/// Appears when the current language is C++.
#define ae2f_add_when_cxx(...)

/// @brief
/// Appears when the current language is C.
#define ae2f_add_when_c(...) __VA_ARGS__

#endif // defined(__cplusplus)

/// @brief
/// Initialiser for trivial structures / classes.
#define ae2f_record_make(type, ...) (ae2f_add_when_c((type) { __VA_ARGS__ }) ae2f_add_when_cxx(type{ __VA_ARGS__ }))

/// @brief
/// # static_cast
#define ae2f_static_cast(t, v) ae2f_add_when_c(((t)(v))) ae2f_add_when_cxx(static_cast<t>(v))

/// @brief
/// # dynamic_cast
#define ae2f_dynamic_cast(t, v) ae2f_add_when_c(((t)(v))) ae2f_add_when_cxx(dynamic_cast<t>(v))

/// @brief
/// # reinterpret_cast
#define ae2f_reinterpret_cast(t, v) ae2f_add_when_c(((t)(v))) ae2f_add_when_cxx(reinterpret_cast<t>(v))

/// @brief
/// # const_cast
#define ae2f_const_cast(t, v) ae2f_add_when_c(((t)(v))) ae2f_add_when_cxx(const_cast<t>(v))

/// @brief
/// Makes a union that reads a memory in two methods. \n
/// `tThen` -> `tNow`
/// @tparam tThen
/// The existing data's type as input.
/// 
/// @tparam tNow
/// Wanted output datatype for casting.
///
/// @param v
/// Input value
#define ae2f_union_cast(tThen, tNow, v) ae2f_add_when_c((union { tThen a; tNow b; }) { v }) ae2f_add_when_cxx(ae2f_union_caster<tThen, tNow>{ v }) .b

/// @brief
/// In C, keyword 'struct' must be written in front of the structure's name in order to use as a type name. \n
/// In C++ that keyword is not required.
/// 
/// This keyword resolves the difference of the rules of two.
#define ae2f_struct ae2f_add_when_c(struct)

/// @brief
/// Suggests the existence of external variable or function, in naming of C. [non-mangling]
#define ae2f_extern ae2f_add_when_c(extern) ae2f_add_when_cxx(extern "C")

/// @brief
/// Class 
#define ae2f_class ae2f_add_when_c(struct) ae2f_add_when_cxx(class)

/// @brief
/// Makes the global variable in naming of C. [non-mangling]
#define ae2f_var ae2f_add_when_cxx(extern "C")

/// @brief
/// Function definitions
#define ae2f_fdef(rtn_t, name, ...) rtn_t (*name)(__VA_ARGS__)

#endif

#if !defined(ae2f_BitVec_h)
#define ae2f_BitVec_h

#if !defined(ae2f_Macro_Cast_h)

/// @brief
/// asdf
#define ae2f_Macro_Cast_h

/// @brief
/// ANSI Code for clearing the console.
/// Clearing all display, moving the cursor on the top.
#define ae2f_Cast_CCls "\033[2J\033[H"

/// @brief
/// simply merge all text inside the round bracket, counting them as a single text block.
#define ae2f_Cast_Merge(...) __VA_ARGS__


#if defined(__cplusplus)

#if !defined(ae2f_Cast_CasterUnion_hpp)
#define ae2f_Cast_CasterUnion_hpp

/// @brief 
/// C++ union definition for @ref ae2f_union_cast
/// @tparam t 
/// @tparam k 
/// @see
/// @ref ae2f_union_cast
template<typename t, typename k>
union ae2f_union_caster {
	t a;
	k b;
};

#endif


/// @brief
/// Appears when the current language is C++.
#define ae2f_add_when_cxx(...) __VA_ARGS__

/// @brief
/// Appears when the current language is C.
#define ae2f_add_when_c(...)

#else

/// @brief
/// Appears when the current language is C++.
#define ae2f_add_when_cxx(...)

/// @brief
/// Appears when the current language is C.
#define ae2f_add_when_c(...) __VA_ARGS__

#endif // defined(__cplusplus)

/// @brief
/// Initialiser for trivial structures / classes.
#define ae2f_record_make(type, ...) (ae2f_add_when_c((type) { __VA_ARGS__ }) ae2f_add_when_cxx(type{ __VA_ARGS__ }))

/// @brief
/// # static_cast
#define ae2f_static_cast(t, v) ae2f_add_when_c(((t)(v))) ae2f_add_when_cxx(static_cast<t>(v))

/// @brief
/// # dynamic_cast
#define ae2f_dynamic_cast(t, v) ae2f_add_when_c(((t)(v))) ae2f_add_when_cxx(dynamic_cast<t>(v))

/// @brief
/// # reinterpret_cast
#define ae2f_reinterpret_cast(t, v) ae2f_add_when_c(((t)(v))) ae2f_add_when_cxx(reinterpret_cast<t>(v))

/// @brief
/// # const_cast
#define ae2f_const_cast(t, v) ae2f_add_when_c(((t)(v))) ae2f_add_when_cxx(const_cast<t>(v))

/// @brief
/// Makes a union that reads a memory in two methods. \n
/// `tThen` -> `tNow`
/// @tparam tThen
/// The existing data's type as input.
/// 
/// @tparam tNow
/// Wanted output datatype for casting.
///
/// @param v
/// Input value
#define ae2f_union_cast(tThen, tNow, v) ae2f_add_when_c((union { tThen a; tNow b; }) { v }) ae2f_add_when_cxx(ae2f_union_caster<tThen, tNow>{ v }) .b

/// @brief
/// In C, keyword 'struct' must be written in front of the structure's name in order to use as a type name. \n
/// In C++ that keyword is not required.
/// 
/// This keyword resolves the difference of the rules of two.
#define ae2f_struct ae2f_add_when_c(struct)

/// @brief
/// Suggests the existence of external variable or function, in naming of C. [non-mangling]
#define ae2f_extern ae2f_add_when_c(extern) ae2f_add_when_cxx(extern "C")

/// @brief
/// Class 
#define ae2f_class ae2f_add_when_c(struct) ae2f_add_when_cxx(class)

/// @brief
/// Makes the global variable in naming of C. [non-mangling]
#define ae2f_var ae2f_add_when_cxx(extern "C")

/// @brief
/// Function definitions
#define ae2f_fdef(rtn_t, name, ...) rtn_t (*name)(__VA_ARGS__)

#endif

#if !defined(ae2f_Cmp_h)
#define ae2f_Cmp_h

/// @warning
/// Two parameters must be comparable with operator.
/// @return
/// One bigger.
#define ae2f_Cmp_TakeGt(a, b)		((a) > (b) ? (a) : (b))

/// @warning
/// Two parameters must be comparable with operator.
/// @return
/// One smaller.
#define ae2f_Cmp_TakeLs(a, b)	((a) < (b) ? (a) : (b))

/// @return
/// The absolute different of two.
#define ae2f_Cmp_Diff(a, b)			(ae2f_Cmp_TakeGt(a, b) - ae2f_Cmp_TakeLs(a, b))

/// @brief
/// Gets the member from the pointer.
/// Given nullptr, the return will be alter.
/// @param ptr The pointer for getting member.
/// @param member The valid member's name. [from the structure]
/// @param alter The alternative value when given nullptr.
#define ae2f_Cmp_TakeMem(ptr, member, alter) ((ptr) ? ((ptr)->member) : (alter))

/// @brief
/// Returns ptr's self.
/// Given nullptr, the return will be alt.
/// @param ptr Self Referring
/// @param alt The alternative value.
#define ae2f_Cmp_TakeSelf(ptr, alt) ((ptr) ? (ptr) : (alt))
#endif // !defined(ae2f_Macro_Compare_h)


/// @brief 
/// The pre-defined index type for Bit vector.
typedef uint8_t ae2f_BitVecI_t;

/// @brief Generates the vector filled in `1`.
/// @param len The length of the filled vector.
/// @tparam vec_t The integer data type.
#define _ae2f_BitVec_Filled(len, vec_t) ae2f_static_cast(vec_t, (sizeof(vec_t) << 3) == (len) ? ae2f_static_cast(vec_t, -1) : (ae2f_static_cast(vec_t, ae2f_static_cast(vec_t, 1) << (len)) - 1))

/// @brief Generates the vector filled in `1`.
/// @param len {ae2f_Macro_BitVecI_t} The length of the filled vector.
#define ae2f_BitVec_Filled(len) _ae2f_BitVec_Filled(len, size_t)

/// @brief
/// Gets the bits of [vector] between index of [start] and [end].
/// @param vector {vec_t} The target for operation.
/// @param start {ae2f_Macro_BitVecI_t} The starting index.
/// @param end {ae2f_Macro_BitVecI_t} The ending index.
/// @tparam vec_t The integer data type.
/// @warning
/// [start] greater than [end] may cause undefined behaviour.
#define _ae2f_BitVec_GetRanged(vector, start, end, vec_t) (((vector) >> (start)) & _ae2f_BitVec_Filled((end) - (start), vec_t))

/// @brief
/// Gets the bits of [vector] between index of [start] and [end]. \n
/// It will normalise the values of [start] and [end] by switching them.
/// @param vector {size_t} The target for operation.
/// @param start {ae2f_Macro_BitVecI_t} The starting index.
/// @param end {ae2f_Macro_BitVecI_t} The ending index.
/// @see _ae2f_Macro_BitVec_GetRanged
#define ae2f_BitVec_GetRanged(vector, start, end) _ae2f_BitVec_GetRanged(vector, ae2f_Cmp_TakeLs(start, end), ae2f_Cmp_TakeGt(start, end), size_t)

/// @brief
/// Gets a bit of [vector] from index of [idx].
/// @param vector {size_t} The target for operation.
/// @param idx {ae2f_Macro_BitVecI_t} The wanted index for searching.
/// @see ae2f_Macro_BitVec_GetRanged
#define ae2f_BitVec_Get(vector, idx) ae2f_BitVec_GetRanged(vector, idx, (idx) + 1)

/// @brief
/// Sets the bits of [vector] from index of [start] and [end] by [val].
/// @param vector {vec_t} The target for operation.
/// @param start {ae2f_Macro_BitVecI_t} The starting index.
/// @param end {ae2f_Macro_BitVecI_t} The ending index.
/// @param val {vec_t} The value to set.
/// @tparam vec_t The integer data type.
/// @warning
/// [start] greater than [end] may cause undefined behaviour.
#define _ae2f_BitVec_SetRanged(vector, start, end, val, vec_t) ((vector) & (~((_ae2f_BitVec_Filled((end) - (start), vec_t)) << start)) | ((val) << start))

/// @brief
/// Sets the bits of [vector] from index of [start] and [end] by [val]. \n
/// It will normalise the values of [start] and [end] by switching them.
/// @param vector {vec_t} The target for operation.
/// @param start {ae2f_Macro_BitVecI_t} The starting index.
/// @param end {ae2f_Macro_BitVecI_t} The ending index.
/// @param val {size_t} The value to set.
#define ae2f_BitVec_SetRanged(vector, start, end, val) _ae2f_BitVec_SetRanged(vector, ae2f_Cmp_TakeLs(start, end), ae2f_Cmp_TakeGt(start, end), (val) & ae2f_BitVec_Filled(ae2f_Cmp_Diff(start, end)), size_t)

/// @brief
/// Sets a bit of [vector] from index of [idx] by [val].
/// @param vector {size_t} The target for operation.
/// @param idx {bool} The wanted index for searching.
/// @see ae2f_Macro_BitVec_GetRanged
#define ae2f_BitVec_Set(vector, idx, val) ae2f_BitVec_SetRanged(vector, idx, (idx) + 1, val)

#endif // !defined(ae2f_Macro_BitVector_h)

#ifndef ae2f_float_h
#define ae2f_float_h

typedef float ae2f_float_t;

#endif 


/// @brief 
/// 32 - byte which means has four channels of [r, g, b, a].
typedef uint32_t ae2f_Bmp_Dot_rgba_t;

#pragma region RGBA get-set

/// @brief
/// Gets the value of channel [R]
/// @param rgb {uint32_t} 
/// 3-channel colour integer.
#define ae2f_BmpDotRGBAGetR(rgb) ae2f_static_cast(uint8_t, ae2f_BitVec_GetRanged(ae2f_static_cast(uint32_t, rgb), 0, 8))

/// @brief
/// Gets the value of channel [G]
/// @param rgb {uint32_t} 3-channel colour integer.
#define ae2f_BmpDotRGBAGetG(rgb) ae2f_static_cast(uint8_t, ae2f_BitVec_GetRanged(ae2f_static_cast(uint32_t, rgb), 8, 16))

/// @brief
/// Gets the value of channel [B]
/// @param rgb {uint32_t} 3-channel colour integer.
#define ae2f_BmpDotRGBAGetB(rgb) ae2f_static_cast(uint8_t, ae2f_BitVec_GetRanged(ae2f_static_cast(uint32_t, rgb), 16, 24))

/// @brief
/// Gets the value of channel [A]
/// @param rgba {uint32_t} 4-channel colour integer.
#define ae2f_BmpDotRGBAGetA(rgba) ae2f_static_cast(uint8_t, ae2f_BitVec_GetRanged(ae2f_static_cast(uint32_t, rgba), 24, 32))

/// @brief
/// Sets the value of channel [R]
/// @param rgb {uint32_t}
/// @param val The value to set
#define ae2f_BmpDotRGBASetR(rgb, val)  ae2f_static_cast(uint32_t, ae2f_BitVec_SetRanged(ae2f_static_cast(uint32_t, rgb), 0, 8, val))

/// @brief
/// Sets the value of channel [G]
/// @param rgb {uint32_t}
/// @param val The value to set
#define ae2f_BmpDotRGBASetG(rgb, val)  ae2f_static_cast(uint32_t, ae2f_BitVec_SetRanged(ae2f_static_cast(uint32_t, rgb), 8, 16, val))

/// @brief
/// Sets the value of channel [B]
/// @param rgb {uint32_t}
/// @param val The value to set
#define ae2f_BmpDotRGBASetB(rgb, val)  ae2f_static_cast(uint32_t, ae2f_BitVec_SetRanged(ae2f_static_cast(uint32_t, rgb), 16, 24, val))

/// @brief
/// Sets the value of channel [A]
/// @param rgba {uint32_t}
/// @param val The value to set
#define ae2f_BmpDotRGBASetA(rgba, val) ae2f_static_cast(uint32_t, ae2f_BitVec_SetRanged(ae2f_static_cast(uint32_t, rgba), 24, 32, val))

/// @brief
/// Generates a new number with three channels configured(initialised).
/// @param r 
/// Initial Value for channel [R]
/// @param g 
/// Initial Value for channel [G]
/// @param b 
/// Initial Value for channel [B]
/// @return {uint32_t} 3-channel colour integer.
#define ae2f_BmpDotRGBMk(r, g, b) ae2f_static_cast(uint32_t, ae2f_static_cast(uint8_t, r) | (ae2f_static_cast(uint16_t, g) << 8) | (ae2f_static_cast(uint32_t, b) << 16))

/// @brief
/// Generates a new number with four channels configured(initialised).
/// @param r 
/// Initial Value for channel [R]
/// @param g 
/// Initial Value for channel [G]
/// @param b 
/// Initial Value for channel [B]
/// @param a
/// Initial Value for channel [A]
/// @return {uint32_t} 4-channel colour integer.
#define ae2f_BmpDotRGBAMk(r, g, b, a) ae2f_static_cast(uint32_t, ae2f_static_cast(uint8_t, r) | (ae2f_static_cast(uint16_t, g) << 8) | (ae2f_static_cast(uint32_t, b) << 16) | (ae2f_static_cast(uint32_t, a) << 24))


/// @brief
/// Generates a new number with seed of [RGB] and initialising value for channel [A].
/// @param rgb
/// Seed RGB Channels
/// @param a
/// Initial value for Channel [A]
/// @return {uint32_t}
#define ae2f_BmpDotRGBMkA(rgb, a) ae2f_BmpDotRGBASetA(rgb, a)

#pragma endregion

#endif


/// @brief
/// The implementation of channel blending.
/// @param a {rtn_t}
/// Channel under operation.
/// @param b {rtn_t}
/// Channel under operation.
/// @param ratio_a
/// Ratio for [a].
/// @tparam rtn_t {typename}
/// Data type to return. \n
/// Normally equals to channel type.
/// @warning choose between f, l, or nothing otherwise would cause error.
/// @return {rtn_t} The blended value.
#define ae2f_BmpBlend_imp(a, b, ratio_a, rtn_t) ae2f_static_cast(rtn_t, (((a) * (ratio_a) + (b) * (ae2f_static_cast(ae2f_float_t, 1) - (ratio_a)))))

/// @brief
/// Get each channel of two, blend two based on Alpha Channel.
/// @param rgba1 {uint32_t}
/// Seed 4-channel integer.
/// @param rgba2 {uint32_t}
/// Seed 4-channel integer.
/// @param iRGB {R | G | B}
/// Channel Name
/// @return {uint8_t}
/// Blended channel value
/// @see @ref ae2f_BmpBlend_imp
/// @see @ref ae2f_BmpDotRGBAGetR
/// @see @ref ae2f_BmpDotRGBAGetG
/// @see @ref ae2f_BmpDotRGBAGetB
/// @see @ref ae2f_BmpDotRGBAGetA
#define ae2f_BmpBlendChannel44_imp(rgba1, rgba2, iRGB) ae2f_BmpBlend_imp(ae2f_BmpDotRGBAGet##iRGB(rgba1), ae2f_BmpDotRGBAGet##iRGB(rgba2), ae2f_BmpDotRGBAGetA(rgba1) / (ae2f_static_cast(ae2f_float_t, ae2f_BmpDotRGBAGetA(rgba1)) + ae2f_BmpDotRGBAGetA(rgba2)), uint8_t)

/// @brief
/// Blends the Channel
/// @param rgb {uint32_t}
/// 3-channel colour integer
/// @param rgba {uint32_t}
/// 4-channel colour integer
/// @param iRGB {R | G | B}
/// Channel Name
/// @return {uint8_t} Blended channel value
#define ae2f_BmpBlendChannel34_imp(rgb, rgba, iRGB) ae2f_BmpBlend_imp(ae2f_BmpDotRGBAGet##iRGB(rgba), ae2f_BmpDotRGBAGet##iRGB(rgb), ae2f_BmpDotRGBAGetA(rgba) / ae2f_static_cast(ae2f_float_t, 255), uint8_t)

/// @brief
/// Alpha channel blending
#define ae2f_BmpBlendA(rgba1, rgba2) ae2f_BmpBlend_imp(ae2f_BmpDotRGBAGetA(rgba1), ae2f_BmpDotRGBAGetA(rgba2), ae2f_static_cast(ae2f_float_t, 0.5))

/// @brief
/// Colour blending as three-to-four channel.
#define ae2f_BmpBlendRGB(rgb, rgba) ae2f_BmpDotRGBMk(ae2f_BmpBlendChannel34_imp(rgba, rgba, R), ae2f_BmpBlendChannel34_imp(rgba, rgba, G), ae2f_BmpBlendChannel34_imp(rgba, rgba, B))

/// @brief
/// Colour blending as four-to-four channel.
#define ae2f_BmpBlendRGBA(rgba1, rgba2) ae2f_BmpDotRGBAMk(ae2f_BmpBlendChannel44_imp(rgba1, rgba2, R), ae2f_BmpBlendChannel44_imp(rgba1, rgba2, G), ae2f_BmpBlendChannel44_imp(rgba1, rgba2, B), ae2f_BmpBlendA(rgba1, rgba2))

#endif 



ae2f_cBmpSrcCpyPrmDef(1);

typedef ae2f_struct ae2f_cBmpSrcCpyPrmDef_i1 ae2f_cBmpSrcCpyPrmDef_i1;

ae2f_SHAREDEXPORT ae2f_err_t ae2f_cBmpSrcGDot(
	const ae2f_struct ae2f_cBmpSrc* src,
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
		const uint8_t* const __src = src->Addr + ae2f_BmpIdxDrive(src->rIdxer, i, j) * (src->ElSize >> 3);

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



ae2f_SHAREDEXPORT ae2f_err_t ae2f_cBmpSrcRef(
	ae2f_struct ae2f_cBmpSrc* dest,
	uint8_t* byte,
	size_t byteLength
) {
	if (byteLength < sizeof(struct ae2f_rBmpHeadBF) + sizeof(struct ae2f_rBmpHeadBI)) 
		return ae2f_errBmpSrcRef_ARR_TOO_SHORT;

	dest->ElSize = ((struct ae2f_rBmpHead*)byte)->rBI.biBitCount;
	dest->rIdxer.Width = dest->rIdxer.IdxXJump = ((struct ae2f_rBmpHead*)byte)->rBI.biWidth;
	dest->rIdxer.CurrX = 0;
	dest->rIdxer.Count = ((struct ae2f_rBmpHead*)byte)->rBI.biWidth * ((struct ae2f_rBmpHead*)byte)->rBI.biHeight;

	dest->Addr = byte + sizeof(struct ae2f_rBmpHeadBF) + sizeof(struct ae2f_rBmpHeadBI);
	return ae2f_errGlob_OK;
}
ae2f_SHAREDEXPORT ae2f_err_t ae2f_cBmpSrcFill(
	ae2f_struct ae2f_cBmpSrc* dest,
	uint32_t colour
) {
	if(!(dest && dest->Addr))
	return ae2f_errGlob_PTR_IS_NULL;

	switch (dest->ElSize) {
	case ae2f_eBmpBitCount_RGB:
	case ae2f_eBmpBitCount_RGBA: break;
	default: return ae2f_errGlob_IMP_NOT_FOUND;
	}

	for(size_t i = 0; i < ae2f_BmpIdxW(dest->rIdxer); i++)	
	for(size_t j = 0; j < ae2f_BmpIdxH(dest->rIdxer); j++)
	for(uint8_t c = 0; c < dest->ElSize; c+=8)
	dest->Addr[(ae2f_BmpIdxDrive(dest->rIdxer, i, j)) * (dest->ElSize >> 3) + (c >> 3)] = ae2f_BitVec_GetRanged(colour, c, c+8);

	return ae2f_errGlob_OK;
}

ae2f_SHAREDEXPORT ae2f_err_t ae2f_cBmpSrcFillPartial(
	ae2f_struct ae2f_cBmpSrc* dest,
	uint32_t colour,

	uint32_t partial_min_x,
	uint32_t partial_min_y,
	uint32_t partial_max_x,
	uint32_t partial_max_y
) {
	if(!(dest && dest->Addr))
	return ae2f_errGlob_PTR_IS_NULL;

	switch (dest->ElSize) {
	case ae2f_eBmpBitCount_RGB:
	case ae2f_eBmpBitCount_RGBA: break;
	default: return ae2f_errGlob_IMP_NOT_FOUND;
	}

	uint32_t width = ae2f_BmpIdxW(dest->rIdxer), height = ae2f_BmpIdxH(dest->rIdxer);

	for(size_t i = partial_min_x; i < width && i < partial_max_x; i++)	
	for(size_t j = partial_min_y; j < height && j < partial_max_y; j++)
	for(uint8_t c = 0; c < dest->ElSize; c+=8)
		dest->Addr[(ae2f_BmpIdxDrive(dest->rIdxer, i, j)) * (dest->ElSize >> 3) + (c >> 3)] = ae2f_BitVec_GetRanged(colour, c, c+8);

	return ae2f_errGlob_OK;
}



#pragma region buffall


ae2f_SHAREDEXPORT ae2f_err_t ae2f_cBmpSrcCpy(
	ae2f_struct ae2f_cBmpSrc* dest,
	const ae2f_struct ae2f_cBmpSrc* src,
	const struct ae2f_cBmpSrcCpyPrm* _srcprm
) {
#define srcprm ae2f_static_cast(const ae2f_cBmpSrcCpyPrmDef_i1*, _srcprm)
	ae2f_err_t code;

	if (!(src && dest && srcprm && src->Addr && dest->Addr)) {
		return ae2f_errGlob_PTR_IS_NULL;
	}

	// check if all alpha is zero
	if (!srcprm->global.Alpha && src->ElSize != ae2f_eBmpBitCount_RGBA)
		return ae2f_errGlob_OK;

	switch (dest->ElSize) {
	case ae2f_eBmpBitCount_RGB:
	case ae2f_eBmpBitCount_RGBA: break;
	default: return ae2f_errGlob_IMP_NOT_FOUND;
	}
	
	ae2f_float_t 
		dotw = (ae2f_BmpIdxW(src->rIdxer) / (ae2f_float_t)srcprm->global.WidthAsResized), 
		doth = (ae2f_BmpIdxH(src->rIdxer) / (ae2f_float_t)srcprm->global.HeightAsResized);

	for (uint32_t y = 0; y < srcprm->global.HeightAsResized; y++) {
		for (uint32_t x = 0; x < srcprm->global.WidthAsResized; x++)
		{
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
				srcprm->global.ReverseIdx
			);

			ae2f_float_t 
			rotatedW = dotw * cos(srcprm->global.RotateXYCounterClockWise) + doth * sin(srcprm->global.RotateXYCounterClockWise),
			rotatedH = doth * cos(srcprm->global.RotateXYCounterClockWise) - dotw * sin(srcprm->global.RotateXYCounterClockWise);

			if(rotatedW < 0) rotatedW = -rotatedW;
			if(rotatedH < 0) rotatedH = -rotatedH;

			if(code != ae2f_errGlob_OK) {
				return code;
			}

			if(el.a == srcprm->global.DataToIgnore) continue;
			
			if(src->ElSize == ae2f_eBmpBitCount_RGB) {
				el.b[3] = srcprm->global.Alpha;
			}

			ae2f_float_t 
			_transx = (ae2f_float_t)_x - srcprm->global.AxisX, 
			_transy = (ae2f_float_t)_y - srcprm->global.AxisY,
			rotatedX = _transx * cos(srcprm->global.RotateXYCounterClockWise) + _transy * sin(srcprm->global.RotateXYCounterClockWise) + srcprm->global.AxisX,
			rotatedY = _transy * cos(srcprm->global.RotateXYCounterClockWise) - _transx * sin(srcprm->global.RotateXYCounterClockWise) + srcprm->global.AxisY;

			for(int32_t i = 0; !i || i < rotatedW; i++) 
			for(int32_t j = 0; !j || j < rotatedH; j++) {
				#pragma region single dot
				uint32_t foridx = 
				ae2f_BmpIdxDrive(
					dest->rIdxer, (uint32_t)rotatedX + i + srcprm->global.AddrXForDest, (uint32_t)rotatedY + j + srcprm->global.AddrYForDest);
				
				if(foridx == -1) goto __breakloopforx;

				for (
					uint8_t* 
					addr = dest->Addr + (dest->ElSize >> 3) * foridx, 
					i = 0; 
					
					i < (src->ElSize >> 3); 
					
					i++
					
					) {
					
					switch (i) {
					default: {
						addr[i] = ae2f_BmpBlend_imp(
							el.b[i], 
							addr[i], 
							((ae2f_static_cast(ae2f_float_t, el.b[3])) / 255.0), 
							uint8_t
						);
					} break;
					case 3: {
						addr[i] = (ae2f_static_cast(uint16_t, addr[i]) + el.b[i]) >> 1;
					}
					}
				}

				#pragma endregion
			}
		}

	__breakloopforx:;
	}

	return ae2f_errGlob_OK;
}
#pragma endregion


ae2f_SHAREDEXPORT ae2f_err_t ae2f_cBmpSrcCpyPartial(
	ae2f_struct ae2f_cBmpSrc* dest,
	const ae2f_struct ae2f_cBmpSrc* src,
	const ae2f_struct ae2f_cBmpSrcCpyPrm* _srcprm,
	uint32_t partial_min_x,
	uint32_t partial_min_y,
	uint32_t partial_max_x,
	uint32_t partial_max_y
) {
	#define srcprm ae2f_static_cast(const ae2f_cBmpSrcCpyPrmDef_i1*, _srcprm)
	ae2f_err_t code;

	if (!(src && dest && srcprm && src->Addr && dest->Addr)) {
		return ae2f_errGlob_PTR_IS_NULL;
	}

	// check if all alpha is zero
	if (!srcprm->global.Alpha && src->ElSize != ae2f_eBmpBitCount_RGBA)
		return ae2f_errGlob_OK;

	switch (dest->ElSize) {
	case ae2f_eBmpBitCount_RGB:
	case ae2f_eBmpBitCount_RGBA: break;
	default: return ae2f_errGlob_IMP_NOT_FOUND;
	}

	
	ae2f_float_t 
		dotw = (ae2f_BmpIdxW(src->rIdxer) / (ae2f_float_t)srcprm->global.WidthAsResized), 
		doth = (ae2f_BmpIdxH(src->rIdxer) / (ae2f_float_t)srcprm->global.HeightAsResized);

	for (uint32_t y = partial_min_y; y < srcprm->global.HeightAsResized && y < partial_max_y; y++) {
		for (uint32_t x = partial_min_x; x < srcprm->global.WidthAsResized && x < partial_max_x; x++)
		{
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
				srcprm->global.ReverseIdx
			);

			ae2f_float_t 
			rotatedW = dotw * cos(srcprm->global.RotateXYCounterClockWise) + doth * sin(srcprm->global.RotateXYCounterClockWise),
			rotatedH = doth * cos(srcprm->global.RotateXYCounterClockWise) - dotw * sin(srcprm->global.RotateXYCounterClockWise);

			if(rotatedW < 0) rotatedW = -rotatedW;
			if(rotatedH < 0) rotatedH = -rotatedH;

			if(code != ae2f_errGlob_OK) {
				return code;
			}

			if(el.a == srcprm->global.DataToIgnore) continue;
			
			if(src->ElSize == ae2f_eBmpBitCount_RGB) {
				el.b[3] = srcprm->global.Alpha;
			}

			ae2f_float_t 
			_transx = (ae2f_float_t)_x - srcprm->global.AxisX, 
			_transy = (ae2f_float_t)_y - srcprm->global.AxisY,
			rotatedX = _transx * cos(srcprm->global.RotateXYCounterClockWise) + _transy * sin(srcprm->global.RotateXYCounterClockWise) + srcprm->global.AxisX,
			rotatedY = _transy * cos(srcprm->global.RotateXYCounterClockWise) - _transx * sin(srcprm->global.RotateXYCounterClockWise) + srcprm->global.AxisY;

			for(int32_t i = 0; !i || i < rotatedW; i++) 
			for(int32_t j = 0; !j || j < rotatedH; j++) {
				#pragma region single dot
				uint32_t foridx = 
				ae2f_BmpIdxDrive(
					dest->rIdxer, (uint32_t)rotatedX + i + srcprm->global.AddrXForDest, (uint32_t)rotatedY + j + srcprm->global.AddrYForDest);
				
				if(foridx == -1) goto __breakloopforx;

				for (
					uint8_t* 
					addr = dest->Addr + (dest->ElSize >> 3) * foridx, 
					i = 0; 
					
					i < (src->ElSize >> 3); 
					
					i++
					
					) {
					
					switch (i) {
					default: {
						addr[i] = ae2f_BmpBlend_imp(
							el.b[i], 
							addr[i], 
							((ae2f_static_cast(ae2f_float_t, el.b[3])) / 255.0), 
							uint8_t
						);
					} break;
					case 3: {
						addr[i] = (ae2f_static_cast(uint16_t, addr[i]) + el.b[i]) >> 1;
					}
					}
				}

				#pragma endregion
			}
		}

	__breakloopforx:;
	}
	return ae2f_errGlob_OK;
}

