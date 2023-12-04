.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int arrays
# Arguments:
#   a0 (int*) is the pointer to the start of arr0
#   a1 (int*) is the pointer to the start of arr1
#   a2 (int)  is the number of elements to use
#   a3 (int)  is the stride of arr0
#   a4 (int)  is the stride of arr1
# Returns:
#   a0 (int)  is the dot product of arr0 and arr1
# Exceptions:
#   - If the number of elements to use is less than 1,
#     this function terminates the program with error code 36
#   - If the stride of either array is less than 1,
#     this function terminates the program with error code 37
# =======================================================

# pseudo c code
# int ans = 0; // s1 - ans
# for (int i = 0; i < numbers; i++) { // t0 - i, a2 - number, a0 - arr0, a1 - arr1
#     ans += arr0[i * stride0] * arr1[i * stride1] // s4 - sizeof(int) = 4 
#                                                  // t1 = offset = i * 4 * stride
#                                                  // t2 = arr + offset = &arr[i * stride]
#                                                  // t3 = *t2 = arr0[i * stride]
#                                                  // t4 = *t2 = arr1[i * stride] 
#                                                  // t5 = t3 * t4 
#                                                  // add s1, s1, t5
# }
# didnt use saved registers, used temp registers to avoid CC error


dot:

    # Prologue
    slti t0, a2, 1 # Check if the number of elements is less than 1 
    li t1, 1 # set t1 to 1
    beq t0, t1, terminate_numbers_invalid # if t0 == 1, terminates the program 

    slti t0, a3, 1 # Check if the stride of arr0 is less than 1 
    beq t0, t1, terminate_stride_invalid # if t0 == 1, terminates the program   

    slti t0, a4, 1 # Check if the stride of arr1 is less than 1 
    beq t0, t1, terminate_stride_invalid # if t0 == 1, terminates the program   


    add t0, x0, x0 # i = 0
    add t6, x0, x0 # ans = 0


loop_start:
    ebreak
    beq t0, a2, loop_end # for t0 from 0 to number-1
    
    addi t2, x0, 4
    mul t1, t0, t2 # t1 - i * sizeof(int)
    mul t1, t1, a3 # t1 = offset = i * 4 * stride0
    add t1, t1, a0 # t1 = a0 + i * sizeof(int) * stride0
    lw t3, 0(t1) # t3 = *t1 = arr0[i * stride0]

    mul t1, t0, t2 # t1 - i * sizeof(int)
    mul t1, t1, a4 # t1 = offset = i * 4 * stride1
    add t1, t1, a1 # t1 = a1 + i * sizeof(int) * stride1
    lw t4, 0(t1) # t4 = *t1 = arr1[i * stride1]

    mul t5, t3, t4
    add t6, t6, t5 


    j loop_continue 


loop_continue:
    addi t0, t0, 1 # ++i
    j loop_start


loop_end:
    # Epilogue
    add a0, x0, t6 # load ans to return value a0

    jr ra





terminate_numbers_invalid:
    li a0, 36 # Load error code 36
    j exit

terminate_stride_invalid:
    li a0, 37 # Load error code 37
    j exit
