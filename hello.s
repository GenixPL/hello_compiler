.global _main
.align 4

.text ; default (not needed) area
_main:
    ; 1. Call write(1, msg, 13)
    mov     x0, #1          ; File descriptor 1 = stdout
    adrp    x1, msg@PAGE    ; Load page base address of msg
    add     x1, x1, msg@PAGEOFF ; Add offset to get full address
    mov     x2, #13         ; String length (13 bytes)
    mov     x16, #4         ; macOS System Call number for write
    svc     #0x80           ; Issue supervisor call (kernel interrupt)

    ; 2. Call exit(0)
    mov     x0, #0          ; Exit code 0
    mov     x16, #1         ; macOS System Call number for exit
    svc     #0x80           ; Issue supervisor call

.data ; Holds read-write static/global variables initialized with explicit values.
msg: ; Variable name
    .ascii  "Hello, World\n"
