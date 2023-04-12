main:
	li a0 5
	jal factorial
	# mv a1 a0
	# li a0 1
	# ecall
	j exit

factorial:
	beq a0 x0 ret1
	addi sp sp -8
	sw ra 0(sp)
	sw s0 4(sp)
	mv s0 a0
	addi a0 a0 -1
	jal factorial
	mul a0 a0 s0
	lw ra 0(sp)
	lw s0 4(sp)
	addi sp sp 8
	ret
ret1:
	li a0 1
	ret

exit:

