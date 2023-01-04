.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
#
# If the length of the vector is less than 1, 
# this function exits with error code 5.
# If the stride of either vector is less than 1,
# this function exits with error code 6.
# =======================================================
dot:

    # Prologue
    addi sp sp -12
    sw s0 0(sp)
    sw s1 4(sp)
    sw ra 8(sp)

    mv s0 a0
    mv s1 a1

    # beq a0 x0 loop_end
    # beq a1 x0 loop_end
    # bge x0 a3 loop_end
    # bge x0 a4 loop_end

    li a0 0
    li t6 4
    mul t3 t6 a3
    mul t4 t6 a4

loop_start:
    beq a2 x0 loop_end
    lw t0 0(s0)
    lw t1 0(s1)
    mul t2 t0 t1
    add a0 a0 t2

    add s0 s0 t3
    add s1 s1 t4
    addi a2 a2 -1
    j loop_start

loop_end:


    # Epilogue
    lw s0 0(sp)
    lw s1 4(sp)
    lw ra 8(sp)
    addi sp sp 12

    ret