.global _main
.global add_numbers
.align 4

.text ; default (not needed) area
_main:
  ; Print the msg
  mov     x0, #1          ; File descriptor 1 = stdout
  adrp    x1, msg@PAGE    ; Load page base address of msg
  add     x1, x1, msg@PAGEOFF ; Add offset to get full address
  mov     x2, #13         ; String length (13 bytes)
  mov     x16, #4         ; macOS System Call number for write
  svc     #0x80           ; Issue supervisor call (kernel interrupt)

  ; Add two numbers

  ; Load first number
  adrp    x1, num1@PAGE
  add     x1, x1, num1@PAGEOFF
  ldr     w1, [x1]
  ; Load second number
  adrp    x2, num2@PAGE
  add     x2, x2, num2@PAGEOFF
  ldr     w2, [x2]
  # Add
  # add     w3, w2, w1
  mov     w0, w2          // Load first argument into w0
  mov     w1, w1          // Load second argument into w1
  bl      add_numbers     // Call the function
  mov    w3, w0
  # Convert to string
  add     w3, w3, #'0' ; Convert result to ASCII digit
  # Store result
  adrp    x1, result@PAGE
  add     x1, x1, result@PAGEOFF
  strb    w3, [x1]

  # Print
  mov     x0, #1
  mov     x2, #1
  mov     x16, #4
  svc     #0x80

  # Exit
  mov     x0, #0          ; Exit code 0
  mov     x16, #1         ; macOS System Call number for exit
  svc     #0x80           ; Issue supervisor call

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
    ret                             // Return to address stored in Link Register (x30)

.data ; Holds read-write static/global variables initialized with explicit values.
msg: ; Variable name
  .ascii  "Hello, World\n"
num1:
  .word 1
num2:
  .word 2
result:
  .byte 0
