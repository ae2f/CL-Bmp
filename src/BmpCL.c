#include <ae2fCL/Bmp/Bmp.h>

static cl_program LIB = 0;

#define ae2fCL_BmpFill_ID 0
#define ae2fCL_BmpRectCpy_ID 1

static cl_kernel kers[] = {
    0, 0
};

ae2f_SHAREDEXPORT cl_int ae2fCL_BmpMk(
    cl_context context,
    cl_uint clDeviceNumber,
    const cl_device_id* lpDevice
) {
    cl_int _err = CL_SUCCESS;

    LIB = clCreateProgramWithSource(context, 1, &ae2fCL_Bmp_Programme, 0, &_err);
    if(_err != CL_SUCCESS) return _err;
    _err = clBuildProgram(LIB, clDeviceNumber, lpDevice, 0, 0, 0);
    if(_err == CL_BUILD_SUCCESS) _err = CL_SUCCESS;
    if(_err != CL_SUCCESS) return _err;

    kers[ae2fCL_BmpFill_ID] = clCreateKernel(LIB, "ae2fCL_BmpKernFill", &_err);
    if(_err != CL_SUCCESS) return _err;

    kers[ae2fCL_BmpRectCpy_ID] = clCreateKernel(LIB, "ae2fCL_BmpKernCpy", &_err);
    if(_err != CL_SUCCESS) return _err;

    return _err;
}

ae2f_SHAREDEXPORT cl_int ae2fCL_BmpDel() {
    cl_int err = CL_SUCCESS;
    if(LIB) err |= clReleaseProgram(LIB); LIB = 0;
    for(size_t i = 0; i < sizeof(kers) / sizeof(cl_kernel); i++) {
        if(kers[i]) err |= clReleaseKernel(kers[i]);
        kers[i] = 0;
    }
    
    return err;
}

#include <ae2fCL/Bmp/Buff.h>
#include <ae2f/Bmp/Dot.h>
#include <stdio.h>

ae2f_SHAREDEXPORT cl_int ae2fCL_BmpFill(
    cl_command_queue queue,
    ae2f_struct ae2fCL_cBmpBuff* dest, 
    ae2f_BmpDotRGBA_t colour
) {
    cl_int err = 0;
    const size_t workcount[3] = { 
        ae2f_BmpIdxW(dest->source->rIdxer), 
        ae2f_BmpIdxH(dest->source->rIdxer),
        dest->source->ElSize >> 3
    };

    err = clSetKernelArg(kers[ae2fCL_BmpFill_ID], 0, sizeof(cl_mem), &dest->head);
    if(err != CL_SUCCESS) return err;
    err = clSetKernelArg(kers[ae2fCL_BmpFill_ID], 1, sizeof(cl_mem), &dest->body);
    if(err != CL_SUCCESS) return err;
    err = clSetKernelArg(kers[ae2fCL_BmpFill_ID], 2, sizeof(ae2f_BmpDotRGBA_t), &colour);
    if(err != CL_SUCCESS) return err;

    cl_event kev = 0;
    err = clEnqueueNDRangeKernel(
        queue, kers[ae2fCL_BmpFill_ID],
        3, 0, workcount, 0, 0, 0, &kev
    );
    if(err != CL_SUCCESS) return err;

    err = clEnqueueReadBuffer(
        queue, dest->body, CL_TRUE, 0,
        workcount[0] * workcount[1] * workcount[2], dest->source->Addr, 1, &kev, 0
    );
    return err;
}

#include <ae2f/Bmp/Src/Rect.h>

ae2f_SHAREDEXPORT cl_int ae2fCL_BmpRectCpy(
    cl_command_queue queue,
    ae2f_struct ae2fCL_cBmpBuff* dest,
    ae2f_struct ae2fCL_cBmpBuff* src,
    const ae2f_struct ae2f_cBmpSrcRectCpyPrm* prm
) {
    cl_int err = 0;
    const size_t workcount[3] = { 
        prm->Resz.x,
        prm->Resz.y,
        dest->source->ElSize >> 3
    };

    err = clSetKernelArg(kers[ae2fCL_BmpRectCpy_ID], 0, sizeof(cl_mem), &dest->head);
    if(err != CL_SUCCESS) return err;
    err = clSetKernelArg(kers[ae2fCL_BmpRectCpy_ID], 1, sizeof(cl_mem), &dest->body);
    if(err != CL_SUCCESS) return err;
    err = clSetKernelArg(kers[ae2fCL_BmpRectCpy_ID], 2, sizeof(cl_mem), &src->head);
    if(err != CL_SUCCESS) return err;
    err = clSetKernelArg(kers[ae2fCL_BmpRectCpy_ID], 3, sizeof(cl_mem), &src->body);
    if(err != CL_SUCCESS) return err;
    err = clSetKernelArg(kers[ae2fCL_BmpRectCpy_ID], 4, sizeof(ae2f_struct ae2f_cBmpSrcRectCpyPrm), prm);
    if(err != CL_SUCCESS) return err;


    cl_event kev = 0;
    err = clEnqueueNDRangeKernel(
        queue, kers[ae2fCL_BmpRectCpy_ID],
        3, 0, workcount, 0, 0, 0, &kev
    );
    if(err != CL_SUCCESS) return err;

    err = clEnqueueReadBuffer(
        queue, dest->body, CL_TRUE, 0,
        workcount[0] * workcount[1] * workcount[2], dest->source->Addr, 1, &kev, 0
    );

    return err;
}