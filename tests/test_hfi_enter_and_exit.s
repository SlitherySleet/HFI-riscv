.section .text
.global _start
_start:
    li a0, 0xfeedface      # Arbitrary exit handler address
    .word 0x0005000b       # hfi_enter a0 (your custom opcode)
    csrr a1, 0x7c0         # read CSR_HFI_STATUS into a1
    .word 0x0000100b       # 0000000 00000 00000 001 00000 0001011
    
    # Exit from QEMU
    li t0, 0x100000       # Load MMIO address of test finisher into t0
    li t1, 0x5555         # Load the shutdown signal value into t1
    sw t1, 0(t0)          # Store the value at the MMIO address
