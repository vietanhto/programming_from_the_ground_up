#PURPOSE - Given a number, this program computes the
#          factorial.  For example, the factorial of
#          3 is 3 * 2 * 1, or 6.  The factorial of
#          4 is 4 * 3 * 2 * 1, or 24, and so on.
#
#This program shows how to call a function recursively.
#as factorial.s --32 -o factorial.o && ld -melf_i386 factorial.o -o factorial && ./factorial; echo $?
    .section .data

    .section .text

    .globl _start
    .globl factorial    #unneeded unless we want to share the function
_start:
    pushl $4            #parameter
    call factorial
    addl $4, %esp

    movl %eax, %ebx
    movl $1, %eax
    int $0x80

factorial:
    pushl %ebp
    movl %esp, %ebp
    movl 8(%ebp), %eax

    cmpl $1, %eax
    je end_factorial

    decl %eax
    pushl %eax
    call factorial
    movl 8(%ebp), %ebx

    imull %ebx, %eax

end_factorial:
    movl %ebp, %esp
    popl %ebp
    ret
