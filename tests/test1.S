    // File: test1.S
    // Purpose: Call hfi_enter, then hfi_exit, and read out hfi_status

    .section .text
    .globl _start
_start:

    // We need to set up the operand registers for hfi_enter if your
    // format has them. This is just an example; adjust register usage
    // based on how you've encoded hfi_enter in QEMU.

    li t0, 0x0            // Suppose we want "no special flags" in our hfi_enter operand
    // hfi_enter t0
    // .word 0xXYZXYZXYZ     // <--- Replace with the correct custom opcode for hfi_enter
                          //      or use a macro definition, depending on how you exposed it.

    // After hfi_enter, we expect that hfi_status is updated internally
    // so that "HFI is enabled." The instructions do no sandboxing yet,
    // but let's test the cycle of toggling bits in the hfi_status register.

    // hfi_exit
    // .word 0xABCABCABC     // <--- Replace with the correct custom opcode for hfi_exit

    // Now, optionally, we can read from hfi_status if you exposed it
    // as a CSR or if QEMU logs the new state. If you have a CSR read
    // instruction for hfi_status, do something like:
    // csrr a0, hfi_status

    // Exit program
    // For a user-mode program, do an ecall or just infinite loop
    // For demonstration, we’ll do a “shutdown” ecall in Linux-user context:
    li a7, 93           // exit syscall on Linux
    ecall
