
%include "LinkedList.mac"

extern malloc

section .text

global ll_create
ll_create:

    push rbp
    mov rbp, rsp

    mov rdi, LinkedList_size
    call malloc                     ; Malloc LinkedList and save it on stack
    push rax

    mov qword[rax], 0               ; Initalize head and tail to be null
    add rax, LinkedList.tail
    mov qword[rax], 0
    
    pop rax                         ; Pop saved pointer off stack and into return register

    pop rbp
    mov rsp, rbp
    ret
