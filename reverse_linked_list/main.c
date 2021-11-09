
#include "main.h"


// void func(int32_t* a, int32_t* b, uint8_t* result, size_t size);
int main(void) {

    struct linked_list_node e = { .data = 1, .next = NULL };
    struct linked_list_node he = { .data = 5, .next = &e };
    struct linked_list_node h = { .data = 9, .next = &he };
    struct linked_list_node head = { .data = 11, .next = &h };

    pp(&head);

    func(&head);

    pp(&head);
}

void pp(struct linked_list_node* ll) {
    struct linked_list_node* c = ll;
    while (c != NULL) {
        printf("%lld -> ", c->data);
        c = c->next;
    }
    printf("\n");
}
