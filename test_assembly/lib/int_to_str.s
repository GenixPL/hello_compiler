.global _int_to_str
.global int_to_str
.align 2

; ------------------------------------------------------------------
; Function: int_to_string
; Input:  x0 = Unsigned 64-bit Integer
; Output: x0 = Pointer to string (allocated on stack frame)
;         x1 = Length of string
; ------------------------------------------------------------------
int_to_str:
_int_to_str:
    ; Stack Frame Allocation:
    ; [sp, #32] .. [sp, #63] : 32-byte local character buffer
    ; [sp, #16] .. [sp, #31] : Saved x21 and lr
    ; [sp, #0]  .. [sp, #15] : Saved x19 and x20
    sub     sp, sp, #64             ; Reserve 64 bytes total on stack
    stp     x19, x20, [sp]          ; Save callee-saved registers
    stp     x21, lr,  [sp, #16]

    mov     x19, x0                 ; x19 = integer remaining
    add     x20, sp, #32            ; x20 = start of local buffer
    mov     x21, x20                ; x21 = current write pointer
    mov     x2, #10                 ; Divisor = 10

.Ldivide_loop:
    udiv    x3, x19, x2             ; x3 = x19 / 10 (Quotient)
    msub    x4, x3, x2, x19         ; x4 = x19 - (x3 * 10) (Remainder)
    add     w4, w4, #'0'            ; Convert remainder to ASCII digit
    strb    w4, [x21], #1           ; Write character and advance pointer
    mov     x19, x3                 ; Update remaining value
    cbnz    x19, .Ldivide_loop      ; Loop while quotient != 0

    mov     w4, #0
    strb    w4, [x21]               ; Null-terminate string
    sub     x1, x21, x20            ; x1 = total length (write ptr - start ptr)

    ; Reverse string in-place within stack frame
    mov     x3, x20                 ; Left pointer (start of string)
    sub     x4, x21, #1             ; Right pointer (end of string)

.Lreverse_loop:
    cmp     x3, x4
    b.hs    .Ldone                  ; Stop when pointers cross

    ldrb    w5, [x3]                ; Swap bytes
    ldrb    w6, [x4]
    strb    w6, [x3], #1
    strb    w5, [x4], #-1
    b       .Lreverse_loop

.Ldone:
    mov     w4, #0
    strb    w4, [x21]               ; Append null-terminator AFTER reversal
    sub     x1, x21, x20            ; x1 = string length (excluding null byte)
    mov     x0, x20                 ; x0 = pointer to string

    ldp     x21, lr,  [sp, #16]     ; Restore saved registers
    ldp     x19, x20, [sp]          ; Restore registers (stack remains allocated for buffer)
    add     sp, sp, #64             ; Clean up stack frame
    ret
