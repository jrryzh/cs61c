.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
#
# If the length of the vector is less than 1, 
# this function exits with error code 8.
# ==============================================================================
relu:
    # 验证vector长度是否小于1
    beq a0 x0 exit8

    # Prologue
    addi sp sp -4
    sw ra 0(sp)

loop_start:
    # 验证当前loop是否已经完成
    beq a1 x0 loop_end
    # 验证当前a_i是否为>0
    lw t0 0(a0)
    addi a0 a0 4
    addi a1 a1 -1
    bge x0 t0 loop_start
    sw x0 0(a0)
    j loop_start

exit8:
    li a0 8
    ecall

loop_end:


    # Epilogue
    lw ra 0(sp)
    addi sp sp 4
    
	ret
