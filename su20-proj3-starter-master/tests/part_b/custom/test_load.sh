python3 binary_to_hex_cpu.py reference_output/cpu-test_load-ref.out > reference.out
python3 binary_to_hex_cpu.py student_output/cpu-test_load-student.out > student.out
diff reference.out student.out