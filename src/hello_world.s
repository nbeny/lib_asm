section .data
hello:
    .string db "Hello World!", 10   ; 10 = \n
    .len    equ $ - hello.string    ; addr .len - addr .string

section .text
    global start
    global _main
    extern _printf

_main:
    ; register on stack (save)
    push rbp
    ; move rbp = rsp ; register stack in scop
    ; for get access to variable
    mov rbp, rsp
    ; sub on sp or rsp ->
    ; (add) up or down the stack
    ; 16 octets not used
    sub rsp, 16
    ; load addr in rdi of the value hello.string
    lea rdi, [rel hello.string]
    ; call function extern
    call _printf
    ; fast clean stack, pop all
    leave
    ret
