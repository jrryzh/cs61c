#include <stddef.h>
#include <stdio.h>
#include "ll_cycle.h"

int ll_has_cycle(node *head) {
    /* your code here */
    node *tortoise = head, *hare = head;

    if (!head || !(*head).next || !(*(*head).next).next) {
        return 0;
    } else {
        tortoise = (*tortoise).next;
        hare = (*(*hare).next).next;
    }

    while (tortoise != hare) {
        if (!(*hare).next || !(*(*hare).next).next) {
            return 0;
        } else {
            tortoise = (*tortoise).next;
            hare = (*(*hare).next).next;
        }
    }
    return 1;

}
