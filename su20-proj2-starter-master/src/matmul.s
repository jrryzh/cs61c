.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
#   The order of error codes (checked from top to bottom):
#   If the dimensions of m0 do not make sense, 
#   this function exits with exit code 2.
#   If the dimensions of m1 do not make sense, 
#   this function exits with exit code 3.
#   If the dimensions don't match, 
#   this function exits with exit code 4.
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0 
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# =======================================================
matmul: 

    # Error checks
    bge x0 a1 exit_2
    bge x0 a2 exit_2
    bge x0 a3 exit3
    bge x0 a4 exit3
    bne a2 a4 exit4

    # Prologue
    addi sp sp -44
    sw s0 0(sp)
    sw s1 4(sp)
    sw s2 8(sp)
    sw s3 12(sp)
    sw s4 16(sp)
    sw s5 20(sp)
    sw s6 24(sp)
    sw s7 28(sp)
    sw s8 32(sp)
    sw s9 36(sp)
    sw ra 40(sp)

    mv s0 a0
    mv s1 a1
    mv s2 a2
    mv s3 a3
    mv s4 a4
    mv s5 a5
    mv s6 a6

    mv s7 s3

    li s8 0
    li s9 0

outer_loop_start:
    j inner_loop_start

inner_loop_start:
    beq s9 s5 inner_loop_end
    mv a0 s0
    mv a1 s3
    mv a2 s2
    li a3 1
    mv a4 s5
    jal dot
    sw a0 0(s6)

    addi s6 s6 4
    addi s9 s9 1
    addi s3 s3 4
    j inner_loop_start

inner_loop_end:
    addi s8 s8 1
    beq s8 s1 outer_loop_end
    li s9 0
    slli t0 s2 2
    add s0 s0 t0
    mv s3 s7
    j outer_loop_start

outer_loop_end:


    # Epilogue
    lw s0 0(sp)
    lw s1 4(sp)
    lw s2 8(sp)
    lw s3 12(sp)
    lw s4 16(sp)
    lw s5 20(sp)
    lw s6 24(sp)
    lw s7 28(sp)
    lw s8 32(sp)
    lw s9 36(sp)
    lw ra 40(sp)
    addi sp sp 44
    
    ret

exit_2:
    li a1 2
    jal exit2

exit3:
    li a1 3
    jal exit2

exit4:
    li a1 4
    jal exit2