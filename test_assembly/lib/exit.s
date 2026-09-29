.global _exit
.global exit
.align 2

exit:
_exit:
    mov     x0, #0          ; Exit code 0
    mov     x16, #1         ; macOS System Call number for exit
    svc     #0x80           ; Issue supervisor call
