
#include "func.h"
#include <stdio.h>

int main(void) {

    const size_t s = 5;
    uint32_t arr[s];

    for (size_t i = s - 1; i >= 0; i--) {
        arr[i] = s - i;
    }

    func(arr, s);

    printf("Array sorted: ");
    for (size_t i = 0; i < s; i++) {
        printf("%d  ", arr[i]);
    }
    printf("\n");
}