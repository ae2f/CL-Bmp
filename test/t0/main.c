#include "test.h"
#include <stdio.h>
int main() {
    int err;
    CHECK_ERR(err = CompileTest(), 0, fail);
    CHECK_ERR(err = MimicTest(), 0, fail);

    fail:
    return err;
}