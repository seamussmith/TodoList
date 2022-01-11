#!/bin/bash

# -g is for debugging symbols
nasm -g -felf64 -o main.o main.asm

ld -dynamic-linker /lib64/ld-linux-x86-64.so.2 -e main -lc -o todo_list main.o
