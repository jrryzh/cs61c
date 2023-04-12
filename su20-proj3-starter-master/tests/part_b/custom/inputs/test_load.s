// 题目要求lh的地址必须为偶数，在此通过规定也可以实现地址为单数情况
addi sp sp -4
li t0 0x12345678
sw t0 0(sp)
lw t1 0(sp)
lh t1 0(sp)
lh t1 1(sp)
lh t1 2(sp)
lb t1 0(sp)
lb t1 1(sp)
lb t1 2(sp)
lb t1 3(sp)
