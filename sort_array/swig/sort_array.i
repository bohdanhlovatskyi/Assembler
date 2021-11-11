/* name of module to use*/
%module sort_array

%{
/* Every thing in this file is being copied in
 wrapper file. We include the C header file necessary
 to compile the interface */
#include "sort_array.h"
%}

/* explicitly lists functions and variables to be interfaced */
void sort_array(uint32_t* input_array, size_t size);
