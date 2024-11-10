#include <ae2f/BmpCL/BmpCL.h>

static cl_program LIB = 0;

ae2f_SHAREDEXPORT cl_int ae2f_BmpCL_Init(
    cl_context context,
    cl_uint clDeviceNumber,
    const cl_device_id* lpDevice
) {
    cl_int _err = CL_SUCCESS;

    LIB = clCreateProgramWithSource(context, 1, &ae2f_BmpCL_Programme, 0, &_err);
    if(_err != CL_SUCCESS) return _err;

    _err = clBuildProgram(LIB, clDeviceNumber, lpDevice, 0, 0, 0);
    if(_err != CL_SUCCESS) return _err;

    // clCreateKernel(LIB, "", &_err);

    return _err;
}

ae2f_SHAREDEXPORT cl_int ae2f_BmpCL_End() {
    cl_int err = CL_SUCCESS;
    if(LIB) clReleaseProgram(LIB); LIB = 0;
    
    return err;
}