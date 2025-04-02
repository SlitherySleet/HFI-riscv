.section .text
.global _start

_start:
    li a0, 0x1111
    li a1, 0x2222
    add a2, a0, a1       # a2 = 0x3333
    j .