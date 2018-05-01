#PURPOSE:  Simple program that exits and returns a
#          status code back to the Linux kernel
#
#INPUT:    none
#
#OUTPUT:   returns a status code.  This can be viewed
#          by typing
#
#          echo $?
#
#          after running the program
#
#VARIABLES:
#          %eax holds the system call number
#          %ebx holds the return status
#
#COMMAND:
#          as exit.s -o exit.o && ld exit.o -o exit && ./exit ; echo $?
.section .data

.section .text
.globl _start

_start:
    movl    $1, %eax    # exit command number in linux
    movl    $100, %ebx  # return value
    int     $0x80       # system call
