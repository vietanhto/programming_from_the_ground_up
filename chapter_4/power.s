#PURPOSE:  Program to illustrate how functions work
#          This program will compute the value of
#          2^3 + 5^2
#
#Everything in the main program is stored in registers,
#so the data section doesn’t have anything.
#
#COMMAND: 
# as power.s --32 -o power.o && ld -melf_i386 power.o -o power && ./power; echo $?
    .section .data

    .section .text

    .globl _start
_start:
    pushl $3            #push second argument
    pushl $2            #push first argument
    call power          #call the function
    addl $8, %esp       #move the stack pointer back
    pushl %eax          #save the first answer 
                        #before calling next function
    
    pushl $2            #push second argument
    pushl $5            #push first argument
    call power
    addl $8, %esp

    popl %ebx
    addl %eax, %ebx

    movl $1, %eax
    int $0x80

#PURPOSE:  This function is used to compute
#          the value of a number raised to
#          a power.
#
#INPUT:    First argument - the base number
#          Second argument - the power to
#                            raise it to
#
#OUTPUT:   Will give the result as a return value
#
#NOTES:    The power must be 1 or greater
#
#VARIABLES:
#          %ebx - holds the base number
#          %ecx - holds the power
#
#          -4(%ebp) - holds the current result
#
#          %eax is used for temporary storage
#

    .type power, @function
power:
    pushl %ebp              #save old base pointer
    movl %esp, %ebp         #make stack pointer the base pointer
    subl $4, %esp           #get room for our local storage

    movl 8(%ebp), %ebx
    movl 12(%ebp), %ecx

    movl %ebx, -4(%ebp)

power_loop_start:
    cmpl $1, %ecx
    je end_power
    movl -4(%ebp), %eax
    imull %ebx, %eax

    movl %eax, -4(%ebp)

    decl %ecx
    jmp power_loop_start

end_power:
    movl -4(%ebp), %eax
    movl %ebp, %esp
    popl %ebp
    ret
