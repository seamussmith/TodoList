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
; args: LinkedList* list, void* data
ll_append:
    push rbp
    mov rbp, rsp

    push rdi
    push rsi

    mov rdi, 0
    mov rax, qword[rbp - 20o]
    mov rsi, rax
    call ln_create 
    push rax

    ; if (linkedList.head == nullptr)
    mov rax, qword[rbp - 10o]
    mov rax, qword[rax]
    cmp rax, 0
    jne headless_else

    mov rax, qword[rbp - 10o]
    mov rbx, qword[rbp - 30o]
    mov qword[rax], rbx
    add rax, LinkedList.tail
    mov qword[rax], rbx

    jmp headless_endif
    ; else
headless_else:

    mov rbx, qword[rbp - 30o]           ; New tail

    mov rax, qword[rbp - 10o]
    add rax, LinkedList.tail            ; Get pointer to pointer to tail node
    mov rax, qword[rax]                 ; Get pointer to tail node
    mov qword[rax], rbx                 ; Dereference pointer to tail node and set it's .next value to the new tail
    
    mov rax, qword[rbp - 10o]           ; Set new reference to tail
    add rax, LinkedList.tail
    mov qword[rax], rbx

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
    call malloc                     ; malloc LinkedListNode
    push rax

    add rax, LinkedListNode.next
    mov rbx, qword[rbp - 10o]       ; Set LinkedListNode.next
    mov qword[rax], rbx

    mov rax, [rbp - 30o] 
    add rax, LinkedListNode.data    ; Set LinkedListNode.data
    mov rbx, qword[rbp - 20o]
    mov qword[rax], rbx
    
    mov rax, qword[rbp - 30o]

    leave
    ret
