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

    # --- Setup Data Region (region 0) for explicit access ---
    li a4, 0x80002000       # base for explicit region 0
    li a5, 0xfffff000       # 4K mask
    li a6, 0                # region 0 = explicit region
    hfi_set_region_size a6, a4, a5

    li a7, 0xE0             # read | write | enable
    hfi_set_region_permissions a6, a7

    # --- Enter Sandbox with Explicit Regions ---
    li t0, 0xfeedfeed       # arbitrary exit handler
    li t1, 1                # region_type=1 (explicit regions)
    hfi_enter t1, t0        # Enable HFI with explicit regions

    # --- Test Explicit Region 0 Load & Store Instructions ---
    
    # Setup base address for region 0
    li t0, 0x80002000
    
    # Test byte operations
    li t1, 0xAB              # test value
    hsb0 t1, 0, t0           # Store byte to region 0
    hlb0 t2, 0, t0           # Load signed byte from region 0
    hlbu0 t3, 0, t0          # Load unsigned byte from region 0
    
    # Test halfword operations
    li t1, 0xABCD            # test value
    hsh0 t1, 4, t0           # Store halfword to region 0
    hlh0 t4, 4, t0           # Load signed halfword from region 0
    hlhu0 t5, 4, t0          # Load unsigned halfword from region 0
    
    # Test word operations
    li t1, 0xABCD1234        # test value
    hsw0 t1, 8, t0           # Store word to region 0
    hlw0 t6, 8, t0           # Load signed word from region 0
    hlwu0 s2, 8, t0          # Load unsigned word from region 0
    
    # Test doubleword operations (if in RV64)
    li t1, 0xABCD12345678    # test value
    hsd0 t1, 16, t0          # Store doubleword to region 0
    hld0 s3, 16, t0          # Load doubleword from region 0
    
    # --- Perform a simple computation with loaded values ---
    add s4, t2, t4            # Add loaded byte and halfword
    add s5, t6, s2            # Add loaded words
    
    # --- Exit and shutdown ---
    hfi_exit
    exit
