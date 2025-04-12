.section .text
.global _start

_start:
    li a0, 0x1111
    li a1, 0x2222
    add a2, a0, a1       # a2 = 0x3333
    
    # Exit from QEMU
    li t0, 0x100000       # Load MMIO address of test finisher into t0
    li t1, 0x5555         # Load the shutdown signal value into t1
    sw t1, 0(t0)          # Store the value at the MMIO address
