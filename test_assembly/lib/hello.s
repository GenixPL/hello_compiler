.global _main
.align 4

.extern add_numbers
.extern print
.extern exit

.text ; default (not needed) area
_main:
  mov x0, 90
  mov x1, 6
  bl int_add
  # store output
  adrp x1, d_2@PAGE
  add x1, x1, d_2@PAGEOFF
  str x0, [x1]
  
  # convert int to string
  adrp x1, d_2@PAGE
  add x1, x1, d_2@PAGEOFF
  ldr x0, [x1]
  bl int_to_str
  # store output
  adrp x1, d_3@PAGE
  add x1, x1, d_3@PAGEOFF
  str x0, [x1]
  
  adrp x0, d_3@PAGE
  add x0, x0, d_3@PAGEOFF
  ldr x0, [x0]
  bl print
  
  b exit

  # convert int to string
  adrp x1, d_9@PAGE
  add x1, x1, d_9@PAGEOFF
  ldr x0, [x1]
  bl int_to_str
  # store output
  adrp x1, str_d_9@PAGE
  add x1, x1, str_d_9@PAGEOFF
  str x0, [x1]

  adrp x0, str_d_9@PAGE
  add x0, x0, str_d_9@PAGEOFF
  ldr x0, [x0]
  bl print

  adrp x0, msg@PAGE
  add x0, x0, msg@PAGEOFF
  bl print
  bl exit

  mov x0, #60
  mov x1, #9
  bl int_add
  bl int_to_str
  bl print
  mov x0, #456
  bl int_to_str
  bl print
  bl exit

  ; Print the msg
  mov     x0, #1          ; File descriptor 1 = stdout
  adrp    x1, msg@PAGE    ; Load page base address of msg
  add     x1, x1, msg@PAGEOFF ; Add offset to get full address
  mov     x2, msg_len
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

.data ; Holds read-write static/global variables initialized with explicit values.
d_0:
  .word 90
d_1:
  .word 6
d_2:
  .word 0
d_3:
  .asciz ""
  .space  50 - (. - d_3), 0
msg: ; Variable name
  .asciz  "Hello, World\n"
  .equ msg_len, . - msg
wtf:
  .asciz "ABC"
num1:
  .word 1
num2:
  .word 2
result:
  .byte 0
d_9:
  .word 88
str_d_9:
  .asciz ""
  .space 50, 0
