#include <stdio.h>
#include "add_three_nums.h"

int main(void) {
    int a = 1;
    int b = 2;
    int c = 3;

    int d = three_sum(a, b, c);

    printf("Result: %d\n", d);
}