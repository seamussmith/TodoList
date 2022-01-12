%ifndef LinkedList_MODULE
%define LinkedList_MODULE

extern malloc

section .text

struc LinkedList

    .head resq 1
    .tail resq 1

endstruc

struc LinkedListNode

    .next resq 1
    .data resq 1

endstruc

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

%endif
