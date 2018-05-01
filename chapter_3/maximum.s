#PURPOSE:  This program finds the maximum number of a
#          set of data items.
#
#VARIABLES: The registers have the following uses:
#
# %edi - Holds the index of the data item being examined
# %ebx - Largest data item found
# %eax - Current data item
#
# The following memory locations are used:
#
# data_items - contains the item data.  A 0 is used
#              to terminate the data
# COMMAND: as maximum.s -o maximum.o && ld maximum.o -o maximum && ./maximum; echo $?
#

    .section    .data
data_items:             # These are the data items
    .long 3,67,34,222,45,75,54,34,44,33,255,11,66,0

    .section    .text

    .globl  _start
_start:
    movl    $0, %edi                  # set %edi = 0;
    movl    data_items(,%edi,4), %eax # load data_items[%edi]
    movl    %eax, %ebx                # ebx = eax


start_loop:
    cmpl    $0, %eax
    je loop_exit
    incl    %edi
    movl    data_items(,%edi,4), %eax # load data_items[%edi]
    cmpl    %ebx, %eax
    jle start_loop

    movl    %eax, %ebx
    jmp start_loop

loop_exit:
    movl    $1, %eax    # exit command number in linux
    int     $0x80       # system call
