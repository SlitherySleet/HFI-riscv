.include "hfi_macros.s"

.section .text
.globl _start

_start:
    li a0, 0xfeedface      # Arbitrary exit handler address
    hfi_enter a0           # Encoded with rs1 = a0 (x10)
    csrr a1, 0x7c0         # CSR_HFI_STATUS
    hfi_exit               # No inputs
    
    # Exit from QEMU
    exit
