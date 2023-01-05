.globl classify

.text
classify:
    # =====================================
    # COMMAND LINE ARGUMENTS
    # =====================================
    # Args:
    #   a0 (int)    argc
    #   a1 (char**) argv: an array of pointers to arrays
    #   a2 (int)    print_classification, if this is zero, 
    #               you should print the classification. Otherwise,
    #               this function should not print ANYTHING.
    # Returns:
    #   a0 (int)    Classification
    # 
    # If there are an incorrect number of command line args,
    # this function returns with exit code 49.
    #
    # Usage:
    #   main.s -m -1 <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>

    addi sp sp -56
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
    sw s10 40(sp)
    sw s11 44(sp)
    sw ra 52(sp)

    mv s4 a2

	# =====================================
    # LOAD MATRICES
    # =====================================

    lw s0 4(a1)
    lw s1 8(a1)
    lw s2 12(a1)
    lw s3 16(a1)

    # Load pretrained m0
    # malloc1
    li a0 4
    jal malloc
    mv s5 a0

    # malloc2
    li a0 4
    jal malloc
    mv s6 a0

    mv a0 s0
    mv a1 s5
    mv a2 s6
    jal read_matrix
    mv s0 a0

    # Load pretrained m1
    # malloc1
    li a0 4
    jal malloc
    mv s7 a0

    # malloc2
    li a0 4
    jal malloc
    mv s8 a0

    mv a0 s1
    mv a1 s7
    mv a2 s8
    jal read_matrix
    mv s1 a0

    # Load input matrix
    # malloc1
    li a0 4
    jal malloc
    mv s9 a0

    # malloc2
    li a0 4
    jal malloc
    mv s10 a0

    mv a0 s2
    mv a1 s9
    mv a2 s10
    jal read_matrix
    mv s2 a0

    # =====================================
    # RUN LAYERS
    # =====================================
    # 1. LINEAR LAYER:    m0 * input
    # 2. NONLINEAR LAYER: ReLU(m0 * input)
    # 3. LINEAR LAYER:    m1 * ReLU(m0 * input)
    
    # LINEAR LAYER 1
    # MALLOC
    lw t0 0(s5)
    lw t1 0(s10)
    mul a0 t0 t1
    slli a0 a0 2
    
    jal malloc
    mv s11 a0

    mv a0 s0
    lw a1 0(s5)
    lw a2 0(s6)
    mv a3 s2
    lw a4 0(s9)
    lw a5 0(s10)
    mv a6 s11

    jal matmul

    # NONLINEAR LAYER
    mv a0 s11
    lw t0 0(s5)
    lw t1 0(s10)
    mul a1 t0 t1

    jal relu

    # LINEAR LAYER 2
    # MALLOC
    lw t0 0(s7)
    lw t1 0(s10)
    mul a0 t0 t1
    slli a0 a0 2
    jal malloc
    mv s6 a0

    mv a0 s1
    lw a1 0(s7)
    lw a2 0(s8)
    mv a3 s11
    lw a4 0(s5)
    lw a5 0(s10)
    mv a6 s6

    jal matmul

    # =====================================
    # WRITE OUTPUT
    # =====================================
    # Write output matrix

    mv a0 s3
    mv a1 s6
    lw a2 0(s7)
    lw a3 0(s10)
    
    jal write_matrix

    # =====================================
    # CALCULATE CLASSIFICATION/LABEL
    # =====================================
    # Call argmax
    mv a0 s6
    lw t0 0(s7)
    lw t1 0(s10)
    mul a1 t0 t1

    jal argmax

    mv s0 a0

    # Print classification
    mv a1 a0
    jal print_int

    # Print newline afterwards for clarity
    li a1 '\n'
    jal print_char

    mv a0 s0

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
    lw s10 40(sp)
    lw s11 44(sp)
    lw ra 52(sp)

    addi sp sp 56

    ret