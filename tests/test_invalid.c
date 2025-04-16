.include "hfi_macros.s"

.section .text
.global _start

_start:
    # --- Step 1: Set implicit CODE region only ---
    li a0, 0x80000000       # base = _start
    li a1, 0xfffff000       # mask for 4K-aligned region
    li a2, 2                # region number = 2 (first code region)
    hfi_set_region_size a2, a0, a1

    # enable | exec → 0b11000000 = 0xC0
    li a3, 0xC0
    hfi_set_region_permissions a2, a3

    # --- Step 2: Enter HFI sandbox ---
    li a4, 0xdeadbeef       # dummy handler
    hfi_enter a4

    # --- Step 3: Invalid memory access (not allowed) ---
    li t0, 0x90000000       # address not in any data region
    li t1, 0x12345678
    sw t1, 0(t0)            # should cause HFI access violation and trap

    # If trap didn't occur, exit HFI (we should not reach this)
    hfi_exit
    exit
