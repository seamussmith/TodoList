%include "LinkedList.mac"

extern malloc
extern free

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

global ll_free
; args: LinkedList*
ll_free:
    push rbp
    mov rbp, rsp

    push rdi

    mov rax, qword[rbp - 10o]
    mov rax, qword[rax] ; Pointer to first node

    cmp rax, 0
    je free_loop_end                ; End loop if node is null
free_loop_start:

    mov rbx, qword[rax]         ; Pointer to next node

    push rax
    push rbx

    mov rdi, rax                ; Free the node
    call free

    pop rbx
    pop rax

    cmp rbx, 0
    je free_loop_end

    mov rax, rbx                ; Set current pointer to the next node
    mov rbx, qword[rax]         ; Set next pointer to the current node's next pointer

    jmp free_loop_start

free_loop_end:

    mov rdi, qword[rbp - 10o]       ; Free the head node
    call free

    leave
    ret

global ll_remove
; args: LinkedList* list, usize index
ll_remove:
    push rbp
    mov rbp, rsp

    push rdi
    push rsi

    mov rbx, 0
    mov rax, rdi
    mov rax, qword[rax]
    mov rcx, rsi
remove_loop_start:

    cmp rcx, 0
    je remove_loop_end

    mov rbx, rax
    mov rax, qword[rax]

    dec rcx
    jmp remove_loop_start

remove_loop_end:

    ; Here: rax is the node to be removed, rbx is the node before the node to be removed
    ; If rbx is nullptr, the node to be removed is the first node
    ; If the given index is out of bounds, thats undefined behavior ¯\_(ツ)_/¯

    ; If rbx.next is null
    ; Set list.tail to rbx

    mov rcx, qword[rbp - 10o]

    cmp qword[rax], 0 ; rax.next
    jne list_tail_check_end

    mov qword[rcx + LinkedList.tail], rbx

list_tail_check_end:

    ; If rbx is null
    ; Set list.head to the next node for rax.next

    cmp rbx, 0
    jne list_head_check_end

    mov rdx, qword[rax]
    mov qword[rcx + LinkedList.head], rdx

    mov rdi, rax
    call free

    ; We no longer have a reference to the node. Horray!
    jmp list_removal_done

list_head_check_end:

    ; rbx cant be null here

    ; INITIATE SWAPPY SWAP
    mov rcx, qword[rax]     ; Set the next pointer for rbx.next to rax.next, effectively removing rax from list
    mov qword[rbx], rcx

    ; GO FREE, MY POINTER
    mov rdi, rax
    call free

list_removal_done:

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
    mov rsi, qword[rbp - 20o]
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
