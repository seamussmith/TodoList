%ifndef LinkedList_MODULE
%define LinkedList_MODULE

section .text

struc LinkedList

    .head resq 1
    .tail resq 1

endstruc

struc LinkedListNode

    .next resq 1
    .data resq 1

endstruc



%endif
