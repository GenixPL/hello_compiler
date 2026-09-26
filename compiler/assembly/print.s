.global _print
.global print
.align 2

.text
// =============================================================================
// Function: print (or _print)
// Description: Prints a null-terminated string to stdout (file descriptor 1).
// Calling Convention: AAPCS64 (ARM64 standard)
// Input:
//   x0 - Pointer to the null-terminated string (const char *)
// Return:
//   void
// =============================================================================
_print:
print:
    // --- Prologue ---
    // Save Frame Pointer (x29) and Link Register (x30) to the stack
    // Pre-decrement SP by 16 bytes (maintaining 16-byte stack alignment)
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp                 // Set Frame Pointer to current SP

    // Check if string pointer in x0 is NULL (0)
    cbz     x0, .Lprint_done

    // --- Calculate string length (strlen) ---
    mov     x1, x0                  // x1 = string address (also argument 2 for sys_write)
    mov     x2, #0                  // x2 = byte count / index (argument 3 for sys_write)

.Lstrlen_loop:
    ldrb    w3, [x1, x2]            // Load byte at (x1 + x2) into 32-bit register w3
    cbz     w3, .Lstrlen_done       // If byte == 0 (null terminator), loop ends
    add     x2, x2, #1              // Increment byte count
    b       .Lstrlen_loop

.Lstrlen_done:
    // If string length is zero (""), nothing needs to be printed
    cbz     x2, .Lprint_done

    // --- macOS System Call: sys_write (syscall #4) ---
    // Parameters for sys_write:
    //   x0: File descriptor (1 = stdout)
    //   x1: Buffer address (already points to the string)
    //   x2: Number of bytes to write (already contains length)
    //   x16: Syscall number (4 for BSD/XNU write)
    mov     x0, #1                  // File descriptor 1 = stdout
    mov     x16, #4                 // macOS/Darwin syscall number for write
    svc     #0x80                   // Supervisor call: trigger kernel interrupt

.Lprint_done:
    // --- Epilogue ---
    // Restore Frame Pointer (x29) and Link Register (x30)
    // Post-increment SP by 16 bytes
    ldp     x29, x30, [sp], #16
    ret                             // Return to caller using address in x30
