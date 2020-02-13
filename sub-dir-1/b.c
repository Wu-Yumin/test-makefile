#include <stdio.h>

#include "api.h"
#include "b.h"

void func_b()
{
    printf("%s: %s\n", __func__, STR_B);
}