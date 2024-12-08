#include <ae2fCL/Bmp/Buff.h>

ae2f_SHAREDEXPORT cl_int ae2fCL_cBmpBuffMk(
    ae2f_struct ae2fCL_cBmpBuff* dest,
    cl_mem_flags flag,
    ae2f_struct ae2f_cBmpSrc* src,
    cl_context ctx
) {
    if(!(src && dest)) return 1;
    if(src->rIdxer.CurrX) return 1;
    if(src->rIdxer.Width != src->rIdxer.IdxXJump) return 1;

    cl_int err = CL_SUCCESS;
    dest->body = clCreateBuffer(
        ctx, flag | CL_MEM_USE_HOST_PTR, 
        ((size_t)(src->rIdxer.Count * src->ElSize)) >> 3, 
        src->Addr, &err
    );
    
    dest->head = clCreateBuffer(
        ctx, CL_MEM_READ_ONLY | CL_MEM_USE_HOST_PTR, 
        sizeof(struct ae2f_cBmpSrc), src, &err
    );

    dest->source = src;
    return err;
}

ae2f_SHAREDEXPORT cl_int ae2fCL_cBmpBuffDel(
    ae2f_struct ae2fCL_cBmpBuff* dest
) {
    cl_int a = 0;
    a = clReleaseMemObject(dest->body);
    a = clReleaseMemObject(dest->head);
    return a;
}