#!/bin/bash

# -g is for debugging symbols
nasm -g -felf64 -o main.o main.asm
nasm -g -felf64 -o LinkedList.o LinkedList.asm

ld -dynamic-linker /lib64/ld-linux-x86-64.so.2 LinkedList.o main.o -e main -lc -o todo_list
