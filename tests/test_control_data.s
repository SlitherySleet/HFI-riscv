.include "hfi_macros.s"

.section .text
.global _start

_start:
    li t1, 0x80001000       # address inside data region
    li t2, 0x12345678
    sw t2, 0(t1)            # store
    lw t3, 0(t1)            # read back
    
    # Exit from QEMU
    exit