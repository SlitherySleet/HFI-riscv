.include "hfi_macros.s"

.section .text
.global _start

_start:
    # --- Setup Code Region (region 2) ---
    li a0, 0x80000000       # base = start of .text
    li a1, 0xfffff000       # 4K mask
    li a2, 2                # region 2 = code
    hfi_set_region_size a2, a0, a1

    li a3, 0xC0             # exec | enable
    hfi_set_region_permissions a2, a3

    # --- Setup Data Region (region 1) ---
    li a4, 0x80001000       # base for .data — just after code
    li a5, 0xfffff000       # 4K mask
    li a6, 1                # region 1 = data
    hfi_set_region_size a6, a4, a5

    li a7, 0xE0             # read | write | enable
    hfi_set_region_permissions a6, a7

    # --- Enter Sandbox ---
    li t0, 2
    li t1, 0xfeedfeed
    hfi_enter t0, t1

    # --- Access valid data memory ---
    li t1, 0x80001000       # address inside data region
    li t2, 0x12345678
    sw t2, 0(t1)            # store
    lw t3, 0(t1)            # read back

    # --- Exit and shutdown ---
    hfi_exit
    exit
