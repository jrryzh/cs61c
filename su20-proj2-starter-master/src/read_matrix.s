.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#   If any file operation fails or doesn't read the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
#
# If you receive an fopen error or eof, 
# this function exits with error code 50.
# If you receive an fread error or eof,
# this function exits with error code 51.
# If you receive an fclose error or eof,
# this function exits with error code 52.
# ==============================================================================
read_matrix:

    # Prologue
    addi sp sp -28
    sw s0 0(sp)
    sw s1 4(sp)
    sw s2 8(sp)
    sw s3 12(sp)
    sw s4 16(sp)
    sw s5 20(sp)
    sw ra 24(sp)

    mv s0 a0
    mv s4 a1
    mv s5 a2

    # Fopen
    mv a1 s0
    li a2 0
    jal ra fopen
    mv s2 a0
    li t0 -1
    beq a0 t0 exit50

    # Fread
    mv a1 s2
    mv a2 s4
    li a3 4
    jal ra fread
    li t0 4
    bne a0 t0 exit51

    mv a1 s2
    mv a2 s5
    li a3 4
    jal ra fread
    li t0 4
    bne a0 t0 exit51

    # Malloc
    lw t0 0(s4)
    lw t1 0(s5)
    mul s3 t0 t1
    slli s3 s3 2
    mv a0 s3
    jal ra malloc
    mv s1 a0

    # Fread
    mv a1 s2
    mv a2 s1
    mv a3 s3
    jal ra fread
    bne a0 s3 exit51

    # Fclose
    mv a1 s2
    jal ra fclose
    bne a0 x0 exit52

    mv a0 s1

    # Epilogue
    lw s0 0(sp)
    lw s1 4(sp)
    lw s2 8(sp)
    lw s3 12(sp)
    lw s4 16(sp)
    lw s5 20(sp)
    lw ra 24(sp)
    addi sp sp 28

    ret

exit48:
    li a1 48
    j exit2

exit50:
    li a1 50
    j exit2

exit51:
    li a1 51
    j exit2

exit52:
    li a1 52
    j exit2