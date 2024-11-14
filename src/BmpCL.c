#include <ae2f/BmpCL/BmpCL.h>

static cl_program LIB = 0;

#define ae2f_BmpCL_KernI_FILL 0

static cl_kernel kers[] = {
    0
};

ae2f_SHAREDEXPORT cl_int ae2f_BmpCL_Init(
    cl_context context,
    cl_uint clDeviceNumber,
    const cl_device_id* lpDevice
) {
    cl_int _err = CL_SUCCESS;

    LIB = clCreateProgramWithSource(context, ae2f_BmpCL_Programme_COUNT, ae2f_BmpCL_Programme, 0, &_err);
    if(_err != CL_SUCCESS) return _err;
    _err = clBuildProgram(LIB, clDeviceNumber, lpDevice, 0, 0, 0);
    if(_err == CL_BUILD_SUCCESS) _err = CL_SUCCESS;
    if(_err != CL_SUCCESS) return _err;

    kers[ae2f_BmpCL_KernI_FILL] = clCreateKernel(LIB, "Fill", &_err);
    if(_err != CL_SUCCESS) return _err;

    return _err;
}

ae2f_SHAREDEXPORT cl_int ae2f_BmpCL_End() {
    cl_int err = CL_SUCCESS;
    if(LIB) err |= clReleaseProgram(LIB); LIB = 0;
    for(size_t i = 0; i < sizeof(kers) / sizeof(cl_kernel); i++) {
        if(kers[i]) err |= clReleaseKernel(kers[i]);
        kers[i] = 0;
    }
    
    return err;
}

ae2f_SHAREDEXPORT cl_int ae2f_BmpCL_Fill(
    cl_mem dest, 
    cl_command_queue queue,
    uint32_t colour, 
    size_t pcount
) {
    cl_int err = 0;

    err = clSetKernelArg(kers[ae2f_BmpCL_KernI_FILL], 0, sizeof(cl_mem), dest);
    if(err != CL_SUCCESS) return err;
    err = clSetKernelArg(kers[ae2f_BmpCL_KernI_FILL], 1, sizeof(uint32_t), &colour);
    if(err != CL_SUCCESS) return err;
    err = clSetKernelArg(kers[ae2f_BmpCL_KernI_FILL], 2, sizeof(uint32_t), &pcount);
    if(err != CL_SUCCESS) return err;

    err = clEnqueueNDRangeKernel(
        queue, kers[ae2f_BmpCL_KernI_FILL], 
        1, 0, &pcount, 0, 0, 0, 0
    );
    
    return err;
}