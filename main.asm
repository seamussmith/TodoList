%include "LinkedList.mac"

global main

extern printf
extern malloc
extern ll_create
extern ln_create
extern ll_append


section .text

struc ListItem

    .description resq 1 ; Pointer to string
    .isDone resb 1      ; Boolean

endstruc

main:
    push rbp
    mov rbp, rsp

    call ll_create
    push rax

    mov rdi, qword[rbp - 10o]
    mov rsi, 69
    call ll_append

    mov rdi, qword[rbp - 10o]
    mov rsi, 420
    call ll_append

    ; Reset stack
    pop rbp
    mov rsp, rbp
    ; Exit syscall
    mov rax, 60
    xor rdi, rdi
    syscall
    ; ret

section .data
    hello: db "Hello, World!", 0
    item_format: db "[%hhx] %s", 10, 0
    numformat: db "%d", 10, 0
