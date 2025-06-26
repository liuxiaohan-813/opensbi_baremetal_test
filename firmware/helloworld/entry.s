    .section .text.entry
    .globl _start
_start:
    /* setup stack */
    la    sp, _sp           # setup stack pointer
    call main
halt:   j     halt                    # enter the infinite loop
