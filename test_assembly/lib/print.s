.global _print
.global print
.align 2

// ------------------------------------------------------------------
// Function: print_string
// Input:    X0 = address of null-terminated string
// Output:   None (prin ts string to stdout)
// ------------------------------------------------------------------
.text
_print:
print:
    // Reserve stack frame and save Link Register (LR/X30) & Frame Pointer (FP/X29)
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp

    mov     x19, x0             // Save string pointer in X19 (callee-saved)

    bl      _strlen             // Call strlen(X0) -> returns length in X0

    // Prepare macOS sys_write (0x2000004)
    mov     x2, x0              // X2 = length returned by _strlen
    mov     x1, x19             // X1 = saved string pointer
    mov     x0, #1              // X0 = stdout (file descriptor 1)
    mov     x16, #4             // macOS sys_write system call
    svc     #0x80               // Issue supervisor call

    // Restore FP and LR, then return
    ldp     x29, x30, [sp], #16
    ret
