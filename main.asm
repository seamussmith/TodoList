
global main

extern printf
extern malloc

section .text

struc ListItem

    .description resq 1 ; Pointer to string
    .isDone resb 1      ; Boolean

endstruc

main:
    push rbp
    mov rbp, rsp

    mov rdi, ListItem_size * 10
    call malloc
    push rax


    xor rcx, rcx
begin_init_loop:

    ; Calculate offset
    mov rax, ListItem_size
    mul rcx
    push rax

    ; Init values for list item
    mov rax, [rbp - 8]
    add rax, [rbp - 16]
    add rax, ListItem.description
    mov qword[rax], hello
    
    mov rax, [rbp - 8]
    add rax, [rbp - 16]
    add rax, ListItem.isDone
    mov byte[rax], 0

    pop rax

    inc rcx
    cmp rcx, 10
    jne begin_init_loop

    xor rcx, rcx
begin_print_loop:

    ; Preserve rcx, push twice to stack align
    push rcx
    push rcx
    mov rdi, item_format

    mov rsi, [rbp - 8]
    add rsi, rcx
    add rsi, ListItem.isDone
    mov rsi, [rsi]

    mov rdx, [rbp - 8]
    add rdx, rcx
    add rdx, ListItem.description
    mov rdx, [rdx]

    call printf
    pop rcx
    pop rcx

    ; pop rax ; Dealloc index, we don't need it anymore
    add rcx, ListItem_size
    cmp rcx, 10 * ListItem_size
    jne begin_print_loop

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
