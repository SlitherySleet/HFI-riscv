    .section .rodata
msg:
    .ascii  "Hello World\n"
msg_len = . - msg  # msg_len holds the length of the string

    .section .text
    .globl _start

# _start is the entry point.
# We'll make a write syscall to print, then an exit syscall.

_start:
    # --------------------------------------------------------------------
    # Syscall to write "Hello World\n" to STDOUT (file descriptor 1).
    #   a0 = 1         (stdout)
    #   a1 = address of the message
    #   a2 = length of the message
    #   a7 = 64        (syscall number for write on RISC-V Linux)
    # --------------------------------------------------------------------
    li    a0, 1               # file descriptor: STDOUT
    la    a1, msg             # load address of our message
    li    a2, msg_len         # length of the message
    li    a7, 64              # syscall number for write
    ecall                     # perform the syscall

    # --------------------------------------------------------------------
    # Syscall to exit with status 0.
    #   a0 = 0     (exit code)
    #   a7 = 93    (syscall number for exit on RISC-V Linux)
    # --------------------------------------------------------------------
    li    a0, 0
    li    a7, 93              # syscall number for exit
    ecall
