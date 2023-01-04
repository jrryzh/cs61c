.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
#
# If the length of the vector is less than 1, 
# this function exits with error code 7.
# =================================================================
argmax:

    # 验证vector长度是否小于1
    beq a0 x0 exit7

    # Prologue
    addi sp sp -12
    sw s0 8(sp)
    sw s1 4(sp)
    sw ra 0(sp)
    
    mv s0 a0
    mv s1 a1

    lw t0 0(a0)
    li t1 0
    li t2 0


loop_start:
    beq s1 x0 loop_end
    lw t3 0(s0)
    bge t0 t3 loop_continue
    lw t0 0(s0)
    mv t1 t2



loop_continue:
    addi s0 s0 4
    addi s1 s1 -1
    addi t2 t2 1
    j loop_start

exit7:
    li a0 7
    ecall

loop_end:
    

    # Epilogue
    lw s0 8(sp)
    lw s1 4(sp)
    lw ra 0(sp)
    addi sp sp 12

    mv a0 t1

    ret