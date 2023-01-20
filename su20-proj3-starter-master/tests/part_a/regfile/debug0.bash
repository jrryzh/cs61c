python3 binary_to_hex_regfile.py reference_output/regfile-allregs-ref.out > reference.out
python3 binary_to_hex_regfile.py student_output/regfile-allregs-student.out > student.out
diff reference.out student.out