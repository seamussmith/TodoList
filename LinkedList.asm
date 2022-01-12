%include "LinkedList.mac"

extern malloc

section .text

global ll_create
ll_create:
    push rbp
    mov rbp, rsp

    mov rdi, LinkedList_size
    call malloc                     ; Malloc LinkedList and save ptr on stack
    push rax

    mov qword[rax], 0               ; Initalize head and tail to be null
    add rax, LinkedList.tail
    mov qword[rax], 0
    
    pop rax                         ; Pop saved pointer off stack and into return register

    leave
    ret

global ll_append
; args: LinkedList*
ll_append:
    push rbp
    mov rbp, rsp

    ; if (linkedList.head == nullptr)
    cmp qword[rdi + LinkedList.head], 0
    jne headless_else



    ; else
headless_else:



headless_endif:

    leave
    ret

global ln_create
; args: void* next, void* data 
ln_create:
    push rbp
    mov rbp, rsp

    push rdi                        ; Save rdi, rsi
    push rsi

    mov rdi, LinkedListNode_size
    call malloc                 
    push rax

    add rax, LinkedListNode.next
    mov rbx, qword[rbp - 10o]
    mov qword[rax], rbx

    mov rax, [rbp - 30o] 
    add rax, LinkedListNode.data
    mov rbx, qword[rbp - 20o]
    mov qword[rax], rbx
    
    mov rax, qword[rbp - 30o]

    leave
    ret
