
#include "main.h"


// struct linked_list_node* func (struct linked_list_node* node);
int main(void) {

    struct linked_list_node e = { .data = 1, .next = NULL };
    struct linked_list_node he = { .data = 5, .next = &e };
    struct linked_list_node h = { .data = 9, .next = &he };
    struct linked_list_node head = { .data = 11, .next = &h };

    pp(&head);

    struct linked_list_node *res = func(&head);

    pp(res);
}

void pp(struct linked_list_node* ll) {
    struct linked_list_node* c = ll;
    while (c != NULL) {
        printf("%lld -> ", c->data);
        c = c->next;
    }
    printf("\n");
}
