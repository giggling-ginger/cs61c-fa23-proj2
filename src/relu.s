.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
#   a0 (int*) is the pointer to the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   None
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# ==============================================================================
relu:
    # Prologue
    slti t0, a1, 1 # Check if the length of the array is less than 1 
    li t1, 1 # set t1 to 1
    beq t0, t1, terminate # if t0 == 1, terminates the program  

    add t0, x0, x0 # t0 = 0

loop_start:
    beq t0, a1, loop_end # for t0 from 0 to a1-1
    addi t2, x0, 4 # t2 - sizeof(int)
    mul t1, t0, t2 # t1 - i * sizeof(int)
    add t2, t1, a0 # t2 = a0 + i * sizeof(int)
    lw t3, 0(t2) # t3 = *t2 = arr[i]
    bge t3, x0, loop_continue # if arr[i] > 0, continue
    add t3, x0, x0 # arr[i] = 0
    sw t3, 0(t2) # store the value back to the address

loop_continue:
    addi t0, t0, 1 # ++i
    j loop_start


loop_end:


    # Epilogue


    jr ra

terminate:
    li a0, 36 # Load error code 36