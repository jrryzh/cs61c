.globl write_matrix

.text
# ==============================================================================
# FUNCTION: Writes a matrix of integers into a binary file
#   If any file operation fails or doesn't write the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes of the file will be two 4 byte ints representing the
#   numbers of rows and columns respectively. Every 4 bytes thereafter is an
#   element of the matrix in row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is the pointer to the start of the matrix in memory
#   a2 (int)   is the number of rows in the matrix
#   a3 (int)   is the number of columns in the matrix
# Returns:
#   None
#
# If you receive an fopen error or eof, 
# this function exits with error code 53.
# If you receive an fwrite error or eof,
# this function exits with error code 54.
# If you receive an fclose error or eof,
# this function exits with error code 55.
# ==============================================================================
write_matrix:

    # Prologue
    addi sp sp -24
    sw s0 0(sp)
    sw s1 4(sp)
    sw a2 8(sp)
    sw a3 12(sp)
    sw s4 16(sp)
    sw ra 20(sp)

    mv s0 a0
    mv s1 a1

    # Fopen
    mv a1 s0
    li a2 1
    jal ra fopen
    mv s4 a0
    li t0 -1
    beq a0 t0 exit53

    # Fwrite
    mv a1 s4
    addi a2 sp 8
    li a3 1
    li a4 4
    jal fwrite

    mv a1 s4
    addi a2 sp 12
    li a3 1
    li a4 4
    jal fwrite

    mv a1 s4
    mv a2 s1
    lw t0 8(sp)
    lw t1 12(sp)
    mul a3 t0 t1
    li a4 4
    jal fwrite

    # Fclose
    mv a1 s4
    jal fclose
    bne a0 x0 exit55

    # Epilogue
    lw s0 0(sp)
    lw s1 4(sp)
    lw a2 8(sp)
    lw a3 12(sp)
    lw s4 16(sp)
    lw ra 20(sp)
    addi sp sp 24

    ret


exit53:
    li a1 53
    j exit2

exit54:
    li a1 54
    j exit2

exit55:
    li a1 55
    j exit2