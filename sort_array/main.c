
#include "func.h"

const size_t s = 5;

int main(void) {

    uint32_t arr[s];

    arr[0] = 7;
    arr[1] = 2;
    arr[2] = 5;
    arr[3] = 1;
    arr[4] = 9;

    func(arr, s);

    printf("Array sorted: ");
    for (size_t i = 0; i < s; i++) {
        printf("%u  ", arr[i]);
    }
    printf("\n");
}