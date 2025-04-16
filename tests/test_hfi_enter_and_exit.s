.include "hfi_macros.s"

.section .text
.global _start

_start:
    # 1. Set base and mask for the code region (region_number = 2)
    # We'll load base = 0x80000000 and mask = 0xfffff000 into registers
    li a0, 0x80000000       # base prefix
    li a1, 0xfffff000       # mask (for 4K code region)

    li a2, 2                # region number for implicit code region
    hfi_set_region_size a2, a0, a1

    # 2. Set permissions: enable | exec
    # HFI_R3_ENABLED_BIT = 7, HFI_R3_EXEC_BIT = 6 → 0b11000000 = 0xC0
    li a3, 0xC0             # permission bits
    hfi_set_region_permissions a2, a3

    # 3. Enter sandbox mode (hfi_enter) with dummy exit handler address
    li a4, 0xdeadbeef       # dummy exit handler
    hfi_enter a4

    # 4. Read something to make sure we didn't crash
    nop                     # should execute normally

    # 5. Exit HFI and signal QEMU to finish
    hfi_exit
    
    exit
