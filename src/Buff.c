#include <ae2f/BmpCL/Buff.h>

ae2f_SHAREDEXPORT cl_mem ae2f_BmpCL_Buff_Mk(
    cl_mem_flags flag,
    const ae2f_struct ae2f_Bmp_cSrc* src,
    cl_context ctx,
    cl_command_queue queue,
    cl_int* reterr
) {
    if(!src) return 0;
    cl_int err = CL_SUCCESS;

    const size_t 
    szhead = sizeof(ae2f_struct ae2f_Bmp_cSrc) - sizeof(uint8_t*),
    szbody = (src->ElSize >> 3) * (src->rIdxer.Count);

    cl_mem buff = 0;

    buff = clCreateBuffer(
        ctx, CL_MEM_READ_ONLY,
        szbody + szhead, 
        0, &err
    );

    if(err != CL_SUCCESS)
    goto __end;

    if ((err = clEnqueueWriteBuffer(
        queue, buff, CL_TRUE, 0,
        szhead,
        src, 0, 0, 0
    )) != CL_SUCCESS) goto __end;

    if ((err = clEnqueueWriteBuffer(
        queue, buff, CL_TRUE, szhead,
        szbody,
        src->Addr, 0, 0, 0
    )) != CL_SUCCESS) goto __end;

    __end:
    if(reterr) reterr[0] = err;
    return buff;
}

#include <stdio.h>

ae2f_extern ae2f_err_t ae2f_BmpCL_Buff_Read(
    cl_mem src,
    cl_command_queue queue,
    ae2f_struct ae2f_Bmp_cSrc* dest,
    ae2f_struct ae2f_Bmp_cSrc* dest_require
) {
    cl_int err = CL_SUCCESS;
    ae2f_struct ae2f_Bmp_cSrc head[1];
    head->Addr = 0;

    if(!(src && dest)) return ae2f_errGlob_PTR_IS_NULL;

    const size_t 
    szhead = sizeof(ae2f_struct ae2f_Bmp_cSrc) - sizeof(uint8_t*);

    switch (err = clEnqueueReadBuffer(
        queue, src, CL_TRUE,
        0, szhead, head, 0, 0, 0
    )) {
        case CL_SUCCESS: break;
        default: 
        printf("Something Fucked\n");
        return ae2f_errGlob_NFOUND;
    }

    if(dest_require) {
        dest_require[0] = head[0];
    }

    if(
        head->ElSize != dest->ElSize ||
        head->rIdxer.Count != dest->rIdxer.Count ||
        head->rIdxer.CurrX != dest->rIdxer.CurrX ||
        head->rIdxer.IdxXJump != dest->rIdxer.IdxXJump ||
        head->rIdxer.Width != dest->rIdxer.Width
    ) {
        // no match
        return ae2f_errGlob_WRONG_OPERATION;
    }

    const size_t szbody
    = (head->ElSize >> 3) * (head->rIdxer.Count);


    switch (err = clEnqueueReadBuffer(
        queue, src, CL_TRUE,
        szhead, szbody, dest, 0, 0, 0
    )) {
        case CL_SUCCESS: break;
        default: return ae2f_errGlob_NFOUND;
    }

    return ae2f_errGlob_OK;
}