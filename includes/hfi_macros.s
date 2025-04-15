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

/* Macro: hfi_enter <reg> (reg = rs1, source of exit_handler) */
.macro hfi_enter reg
    .set opcode, 0x0B        /* custom-0 */
    .set funct3, 0
    .set funct7, 0
    .set rd, 0
    .set rs1, \reg
    .set rs2, 0
    .word (funct7 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | opcode
.endm

/* Macro: hfi_exit (no operands) */
.macro hfi_exit
    .set opcode, 0x0B
    .set funct3, 1
    .set funct7, 0
    .set rd, 0
    .set rs1, 0
    .set rs2, 0
    .word (funct7 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | opcode
.endm

.macro exit
    li t0, 0x100000
    li t1, 0x5555
    sw t1, 0(t0)
.endm
