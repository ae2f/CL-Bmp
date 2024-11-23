#include <ae2f/BmpCL/Programme.h>

/// @brief 
/// Modular programming has been doomed for cl kernel code since it has no include. \n
/// By little sprinkle of python would implements the pre-processor #incldue.
extern "C" ae2f_SHAREDEXPORT const char* ae2f_BmpCL_Programme[
	ae2f_BmpCL_Programme_COUNT
] = {
	#include "Programme/a.clh"
	,
	#include "Programme/b.clh"
};