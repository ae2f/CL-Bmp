#include <ae2f/BmpCL/Buff.h>

ae2f_SHAREDEXPORT cl_int ae2f_cBmpCLBuffMk(
    ae2f_struct ae2f_cBmpCLBuff* dest,
    cl_mem_flags flag,
    ae2f_struct ae2f_cBmpSrc* src,
    cl_context ctx,
    cl_command_queue queue
) {
    if(!(src && dest)) return 1;
    if(src->rIdxer.CurrX) return 1;
    if(src->rIdxer.Width != src->rIdxer.IdxXJump) return 1;

    cl_int err = CL_SUCCESS;
    dest->body = clCreateBuffer(ctx, flag | CL_MEM_USE_HOST_PTR, src->rIdxer.Count * src->rIdxer.Count >> 3, src->Addr, &err);
    dest->head = clCreateBuffer(ctx, flag | CL_MEM_USE_HOST_PTR, sizeof(struct ae2f_cBmpSrc), src, &err);
    dest->source = src;
    return err;
}

ae2f_SHAREDEXPORT cl_int ae2f_cBmpCLBuffDel(
    ae2f_struct ae2f_cBmpCLBuff* dest
) {
    cl_int a = 0;
    a = clReleaseMemObject(dest->body);
    a = clReleaseMemObject(dest->head);
    return a;
}