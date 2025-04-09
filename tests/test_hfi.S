.section .text
.global _start
_start:
    li a0, 0xfeedface      # Arbitrary exit handler address
    .word 0x000a000b       # hfi_enter a0 (your custom opcode)
    csrr a1, 0x7c0         # read CSR_HFI_STATUS into a1
    j .
