#ifndef _EQUATIONS_TO_SOLVE
#define _EQUATIONS_TO_SOLVE

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

struct linked_list_node
{
    int64_t data;
    struct linked_list_node* next;
};

struct linked_list_node* func (struct linked_list_node* node);
void pp(struct linked_list_node* ll); 

#endif