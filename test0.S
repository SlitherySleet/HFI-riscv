    // File: test0.S
    // Purpose: just set return exit code to 5

    .section .text
    .globl main
main:
    li a0, 5      // return code
    li a7, 93     // syscall # for exit
    ecall