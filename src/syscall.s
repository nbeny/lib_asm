; mac solution syscall, it's get a number and put in this addr
%define MACH_SYSCALL(nb)    0x20000000 | nb
; define STDOUT
%define STDOUT              1
; define WRITE
%define WRITE               4

section .data
hello:
    .string db "Hello World!", 10   ; 10 = \n
    .len    equ $ - hello.string    ; addr .len - addr .string

section .text
    global start
    global _main

start:
  call _main
  ret

_main:
    ; register on stack (save)
    push rbp
    ; move rbp = rsp ; register stack in scop
    ; for get access to variable
    mov rbp, rsp
    ; sub on sp or rsp ->
    ; add or remove on stack
    ; 16 octets not used
    sub rsp, 16

    ; set register rdi
    mov rdi, STDOUT
    ; load addr in rdi of the value hello.string
    lea rsi, [rel hello.string]
    ; the size
    mov rdx, hello.len

    ; MACH_SYSCALL(WRITE) = 0x20000004
    ; 
    mov rax, MACH_SYSCALL(WRITE)
    ; interuption syscall
    syscall

    ; fast clean stack, pop all
    leave
    ret
