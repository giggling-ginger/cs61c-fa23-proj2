.globl argmax

.text
# =================================================================
# FUNCTION: Given a int array, return the index of the largest
#   element. If there are multiple, return the one
#   with the smallest index.
# Arguments:
#   a0 (int*) is the pointer to the start of the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   a0 (int)  is the first index of the largest element
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# =================================================================

# pseudo c code
# // t0 - i, t1 - i * sizeof(int), t2 - &(arr[i], t3 = arr[i]
# int max_ans = arr[0], max_idx = 0; // t4 - max_ans, t5 - max_idx
# for (int i = 0; i < arr.length; i++) { // t0 - i, t0 < a1
#     if (arr[i] > max_ans) { 
#         max_ans = arr[i];
#         max_idx = i;
#     }
# }


argmax:
    # Prologue
    slti t0, a1, 1 # Check if the length of the array is less than 1 
    li t1, 1 # set t1 to 1
    beq t0, t1, terminate_len_invalid # if t0 == 1, terminates the program  

    add t0, x0, x0 # t0 = 0


    lw t3, 0(a0) # t3 = arr[0]

    add t4, x0, t3 # t4 = arr[0]
    add t5, x0, x0 # t5 = 0


    slti t0, a1, 2 # Check if the length of the array equals to 1
    li t1, 1
    beq t0, t1, terminate_len_1


loop_start:
    beq t0, a1, loop_end # for t0 from 0 to a1-1
    addi t2, x0, 4 # t2 - sizeof(int)
    mul t1, t0, t2 # t1 - i * sizeof(int)
    add t2, t1, a0 # t2 = a0 + i * sizeof(int)
    lw t3, 0(t2) # t3 = *t2 = arr[i]

    bge t4, t3, loop_continue # if max_ans >= arr[i], continue

    add t4, t3, x0 # max_ans = arr[i];
    add t5, t0, x0 # max_idx = i;


loop_continue:
    addi t0, t0, 1 # ++i
    j loop_start


loop_end:
    # Epilogue
    add a0, x0, t5 # load max_idx to return value a0

    jr ra

terminate_len_invalid:
    li a0, 36 # Load error code 36
    j exit


terminate_len_1:
    add a0, x0, x0 # return index 0

