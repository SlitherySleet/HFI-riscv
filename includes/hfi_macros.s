/* Register aliases (optional but convenient) */
.set zero, 0
.set ra,   1
.set sp,   2
.set gp,   3
.set tp,   4
.set t0,   5
.set t1,   6
.set t2,   7
.set s0,   8
.set fp,   8
.set s1,   9
.set a0,  10
.set a1,  11
.set a2,  12
.set a3,  13
.set a4,  14
.set a5,  15
.set a6,  16
.set a7,  17
.set s2,  18
.set s3,  19
.set s4,  20
.set s5,  21
.set s6,  22
.set s7,  23
.set s8,  24
.set s9,  25
.set s10, 26
.set s11, 27
.set t3,  28
.set t4,  29
.set t5,  30
.set t6,  31

/* Macro: hfi_enter rs1 (exit handler in rs1) */
.macro hfi_enter rs1, rs2
    .set opcode_hfi, 0x0B
    .set funct3_hfi, 0
    .set funct7_hfi, 0
    .set rd_hfi, 0
    .set rs1_hfi, \rs1
    .set rs2_hfi, \rs2
    .word (funct7_hfi << 25) | (rs2_hfi << 20) | (rs1_hfi << 15) | (funct3_hfi << 12) | (rd_hfi << 7) | opcode_hfi
.endm

/* Macro: hfi_exit (no operands) */
.macro hfi_exit
    .set opcode_hfi, 0x0B
    .set funct3_hfi, 1
    .set funct7_hfi, 0
    .set rd_hfi, 0
    .set rs1_hfi, 0
    .set rs2_hfi, 0
    .word (funct7_hfi << 25) | (rs2_hfi << 20) | (rs1_hfi << 15) | (funct3_hfi << 12) | (rd_hfi << 7) | opcode_hfi
.endm

/* Macro: hfi_set_region_size rd (region number), rs1 (base), rs2 (mask/bound) */
.macro hfi_set_region_size rd, rs1, rs2
    .set opcode_hfi, 0x0B
    .set funct3_hfi, 2
    .set funct7_hfi, 0
    .set rd_hfi, \rd
    .set rs1_hfi, \rs1
    .set rs2_hfi, \rs2
    .word (funct7_hfi << 25) | (rs2_hfi << 20) | (rs1_hfi << 15) | (funct3_hfi << 12) | (rd_hfi << 7) | opcode_hfi
.endm

/* Macro: hfi_set_region_permissions rs1 (region set), rs2 (perm byte) */
.macro hfi_set_region_permissions rs1, rs2
    .set opcode_hfi, 0x0B
    .set funct3_hfi, 3
    .set funct7_hfi, 0
    .set rd_hfi, 0
    .set rs1_hfi, \rs1
    .set rs2_hfi, \rs2
    .word (funct7_hfi << 25) | (rs2_hfi << 20) | (rs1_hfi << 15) | (funct3_hfi << 12) | (rd_hfi << 7) | opcode_hfi
.endm

/* Macro: exit — MMIO test finisher shutdown */
.macro exit
    li t0, 0x100000
    li t1, 0x5555
    sw t1, 0(t0)
.endm
