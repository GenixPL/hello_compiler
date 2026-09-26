.global add_numbers

.text
add_numbers:
    // --- Prologue ---
    stp   x29, x30, [sp, #-16]!   // Push Frame Pointer (x29) & Link Register (x30)
                                  // Pre-decrement SP by 16 bytes (16-byte alignment required)
    mov   x29, sp                 // Set Frame Pointer to current SP

    // --- Body ---
                                  // AAPCS64: Argument 1 = x0, Argument 2 = x1
    add   x0, x0, x1              // x0 = x0 + x1 (x0 holds the return value)

    // --- Epilogue ---
    ldp   x29, x30, [sp], #16     // Restore x29 & x30, post-increment SP by 16 bytes
    ret                            // Return to address stored in Link Register (x30)
