.macro hfi_enter reg
  .insn r 0x0B, 0, 0, \reg, 0
.endm

.macro hfi_exit
  .insn r 0x0B, 1, 0, 0, 0
.endm