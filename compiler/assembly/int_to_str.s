.global _int_to_str
.global int_to_str
.align 2

; ------------------------------------------------------------------
; Function: int_to_str
; Input:  x0 = Unsigned 64-bit Integer
;         x1 = Pointer to destination buffer
; Output: x0 = Pointer to destination buffer
;         x1 = String length
; ------------------------------------------------------------------
int_to_str:
_int_to_str:
    // Save callee-saved registers (only need 32 bytes for registers now)
    sub     sp, sp, #32
    stp     x19, x20, [sp]
    stp     x21, lr,  [sp, #16]

    mov     x19, x0                 // x19 = integer remaining
    mov     x20, x1                 // x20 = start of destination buffer (from x1)
    mov     x21, x1                 // x21 = current write pointer
    mov     x2, #10                 // Divisor = 10

.Ldivide_loop:
    udiv    x3, x19, x2             // x3 = x19 / 10 (Quotient)
    msub    x4, x3, x2, x19         // x4 = x19 - (x3 * 10) (Remainder)
    add     w4, w4, #'0'            // Convert to ASCII digit
    strb    w4, [x21], #1           // Write character directly to buffer & advance
    mov     x19, x3                 // Update remaining value
    cbnz    x19, .Ldivide_loop      // Loop while quotient != 0

    mov     w4, #0
    strb    w4, [x21]               // Null-terminate string

    // Reverse string in-place inside destination buffer
    mov     x3, x20                 // Left pointer (start)
    sub     x4, x21, #1             // Right pointer (end)

.Lreverse_loop:
    cmp     x3, x4
    b.hs    .Ldone                  // Stop when pointers cross

    ldrb    w5, [x3]                // Swap characters
    ldrb    w6, [x4]
    strb    w6, [x3], #1
    strb    w5, [x4], #-1
    b       .Lreverse_loop

.Ldone:
    sub     x1, x21, x20            // x1 = length of string
    mov     x0, x20                 // x0 = pointer to destination buffer

    ldp     x21, lr,  [sp, #16]     // Restore registers
    ldp     x19, x20, [sp]
    add     sp, sp, #32             // Restore stack
    ret
