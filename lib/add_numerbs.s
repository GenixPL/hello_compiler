.global add_numbers

.text
add_numbers:
    // --- Prologue ---
    stp   x29, x30, [sp, #-16]!   // Push Frame Pointer (x29) & Link Register (x30)
                                  // Pre-decrement SP by 16 bytes (16-byte alignment required)
    mov   x29, sp                 // Set Frame Pointer to current SP

    bl non_breaking_print

    // --- Body ---
                                  // AAPCS64: Argument 1 = x0, Argument 2 = x1
    add   x0, x0, x1              // x0 = x0 + x1 (x0 holds the return value)

    // --- Epilogue ---
    ldp   x29, x30, [sp], #16      // Restore x29 & x30, post-increment SP by 16 bytes
    ret                            // Return to address stored in Link Register (x30)

non_breaking_print:
  // Push to stack
  stp     x0, x1, [sp, #-32]!
  stp     x2, x16, [sp, #16]

  // Do the work
  mov     x0, #1
  adrp    x1, msg@PAGE        ; Load page base address of msg
  add     x1, x1, msg@PAGEOFF ; Add offset to get full address
  mov     x2, msg_len
  mov     x16, #4             ; macOS System Call number for write
  svc     #0x80               ; Issue supervisor call (kernel interrupt)

  // Pop from stack
  ldp     x2, x16, [sp, #16]
  ldp     x0, x1, [sp], #32

  // Finish
  ret
    
breaking_print:
  // Do the work
  mov     x0, #1
  adrp    x1, msg@PAGE        ; Load page base address of msg
  add     x1, x1, msg@PAGEOFF ; Add offset to get full address
  mov     x2, msg_len         
  mov     x16, #4             ; macOS System Call number for write
  svc     #0x80               ; Issue supervisor call (kernel interrupt)
  // Finish
  ret

  .data
  msg:
    .ascii "DUPA\n"
    .equ msg_len, . - msg
