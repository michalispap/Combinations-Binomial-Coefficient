#PAPAPETROS MICHAIL 3180149
.text
.globl run
run:
    li $v0, 4
    la $a0, msg_give_n
    syscall                   #prints msg_give_n 

    li $v0, 5
    syscall
    move $t0, $v0             #requests user input (n)
 
    li $v0, 4
    la $a0, null_msg
    syscall                   #changes line

    li $v0, 4
    la $a0, msg_give_k
    syscall                   #prints msg_give_k

    li $v0, 5
    syscall
    move $t1, $v0             #requests user input (k)

    blt $t0, $t1, ELSE
    blt $t1, $0, ELSE         #checks if n >= k >= 0

    li $v0, 4
    la $a0, null_msg
    syscall                   #changes line

    li $v0, 4
    la $a0, final_msg_1
    syscall                   #prints final_msg_1

    li $v0, 1
    move $a0, $t0
    syscall                   #prints $t0 (n's value) 

    li $v0, 4
    la $a0, final_msg_2
    syscall                   #prints final_msg_2

    li $v0, 1
    move $a0, $t1
    syscall                   #prints $t1 (k's value)

    li $v0, 4
    la $a0, final_msg_3       
    syscall                   #prints final_msg_3

    li $t2, 1                 #initialises i's value to 1 (i: counter)
    li $t3, 1                 #initialises factorial_n's value to 1
LOOP1:
    beq $t0, $t2, CONTINUE1
    addi $t2, $t2, 1
    mul $t3, $t3, $t2
    j LOOP1                   #computes factorial_n's value using a for-loop

CONTINUE1:
    li $t2, 1                 #initialises i's value to 1 (i: counter)
    li $t4, 1                 #initialises factorial_k's value to 1
    j LOOP2

LOOP2:
    beq $t1, $t2, CONTINUE2
    addi $t2, $t2, 1
    mul $t4, $t4, $t2
    j LOOP2                   #computes factorial_k's value using a for-loop     

CONTINUE2:
    li $t2, 1                 #initialises i's value to 1 (i: counter)
    li $t5, 1                 #initialises factorial_n_k's value to 1
    sub $t0, $t0, $t1         #n -= k
    j LOOP3

LOOP3:
    beq $t0, $t2, CONTINUE3
    addi $t2, $t2, 1
    mul $t5, $t5, $t2
    j LOOP3                   #computes factorial_n_k's value using a for-loop 

CONTINUE3:
    mul $t6, $t4, $t5         #$t6 = factorial_k * factorial_n_k
    div $t7, $t3, $t6         #$t7 = factorial_n / $t6
    li $v0, 1
    move $a0, $t7             
    syscall                   #prints $t7 (binomial coefficient's value)
    j EXIT

ELSE:                         #goes to "ELSE" label in case of wrong user input
    li $v0, 4
    la $a0, null_msg
    syscall                   #changes line

    li $v0, 4
    la $a0, error_msg        
    syscall                   #prints error_msg 

EXIT:
    li $v0, 10
    syscall 
    .end run                  #exits program
    
.data
msg_give_n: .asciiz "Enter number of objects in the set (n): "
msg_give_k: .asciiz "Enter number to be chosen (k): "
null_msg: .asciiz "\n"
error_msg: .asciiz "Please enter n >= k >= 0 \n"
final_msg_1: .asciiz "C("
final_msg_2: .asciiz ", "
final_msg_3: .asciiz ") = "