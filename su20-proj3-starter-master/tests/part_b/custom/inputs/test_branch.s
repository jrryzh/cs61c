addi t0 x0 0
addi t1 x0 1
addi t2 x0 -1
taken_1:
beq t0 x0 taken_3
taken_2:
bne t0 t1 taken_4
taken_3:
blt t2 t1 taken_2
taken_4:
bge t1 t2 taken_6
taken_5:
bgeu t2 t0 end_taken
taken_6:
bltu t1 t2 taken_5
end_taken:

not_taken:
beq t0 t1 taken_1
bne t0 x0 taken_1
blt t1 t2 taken_1
bge t2 t1 taken_1
bgeu t1 t2 taken_1
bltu t2 t1 taken_1

