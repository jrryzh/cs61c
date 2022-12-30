#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "lfsr.h"

uint16_t get_bit(uint16_t * x, uint16_t n) {
    return * x >> n << 15 >> 15;
}

void lfsr_calculate(uint16_t *reg) {
    /* YOUR CODE HERE */
    uint16_t a;
    a = get_bit(reg, 0) ^  get_bit(reg, 2);
    a = get_bit(reg, 3) ^ a;
    a = get_bit(reg, 5) ^ a;
    * reg = (* reg >> 1) + (a << 15);
}

