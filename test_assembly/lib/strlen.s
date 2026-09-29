.global _strlen
.global strlen
.align 2

// ------------------------------------------------------------------
// Function: strlen
// Input:    X0 = address of null-terminated string
// Output:   X0 = string length in bytes
// ------------------------------------------------------------------
.text:
_strlen:
strlen:
    mov     x1, x0              // Save original starting address into X1

.Lloop:
    ldrb    w2, [x0]            // Load current byte into register W2
    cbz     w2, .Ldone          // If byte is 0 (\0), jump to calculation
    add     x0, x0, #1          // Advance pointer to next byte
    b       .Lloop              // Continue checking next character

.Ldone:
    sub     x0, x0, x1          // Return value (X0) = current address (X0) - start address (X1)
    ret                         // Return to caller with length in X0
