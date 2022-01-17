%include "LinkedList.mac"

global main

extern printf
extern malloc
extern ll_create
extern ln_create
extern ll_append
extern ll_free
extern ll_remove
extern ll_get
extern strtok_r
extern gets

section .text

struc ListItem

    .description resq 1 ; Pointer to string
    .isDone resb 1      ; Boolean

endstruc

%define CMD_UNKNOWN 0
%define CMD_LIST 1
%define CMD_ADD 2

; args: char* description
li_create:
    push rbp
    mov rbp, rsp

    push rdi

    mov rdi, ListItem_size
    call malloc
    push rax

    mov rbx, qword[rbp - 10o]
    mov qword[rax], rbx

    add rax, ListItem.isDone
    mov byte[rax], 0

    pop rax

    leave
    ret

main:
    push rbp
    mov rbp, rsp

    call ll_create
    push rax

loop:

    mov rdi, 256
    call malloc
    push rax

    push rbp
    mov rdi, prompt
    call printf
    pop rbp

    mov rdi, qword[rbp - 20o]   ; MAIN.aSM:70: WaRNing: tHe `geTs' fUnCTIOn is DaNGERoUs anD shOULd NoT Be UsEd.
    call gets



    sub rsp, 10o
    jmp loop
    ; Exit syscall
    mov rax, 60
    xor rdi, rdi
    syscall
    leave
    ret

section .data
    prompt: db "> ", 0
    item_format: db "%lld. [%hhx] %s", 10, 0
    numformat: db "%d", 10, 0

