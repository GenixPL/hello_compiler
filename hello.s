.global _main
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
  adrp    x1, num2@PAGE
  add     x1, x1, num2@PAGEOFF
  ldr     w2, [x1]
  ; Add
  ; TODO(genix): it fails, it prints 2 (with 1 + 2)
  add     w2, w2, w3
  add     w2, w2, #'0' ; Convert result to ASCII digit
  adrp    x1, result@PAGE
  add     x1, x1, result@PAGEOFF
  strb    w2, [x1]
  ; Print
  mov     x0, #1
  mov     x2, #1
  mov     x16, #4
  svc     #0x80

  ; Exit
  mov     x0, #0          ; Exit code 0
  mov     x16, #1         ; macOS System Call number for exit
  svc     #0x80           ; Issue supervisor call

.data ; Holds read-write static/global variables initialized with explicit values.
msg: ; Variable name
  .ascii  "Hello, World\n"
num1:
  .word 1
num2:
  .word 2
result:
  .byte 0
