#!/bin/bash

#Program: 
#Author: Jared De Los Santos

rm *.o
rm *.out

echo "Assemble triangle.asm"
nasm -f elf64 -l triangle.lis -o triangle.o triangle.asm

echo "Compile pythagoras.c"
gcc -c -m64 -Wall -std=c11 -fno-pie -no-pie -o pythagoras.o pythagoras.c 

echo "Link the object files"
gcc -m64 -std=c11 -fno-pie -no-pie -o a.out triangle.o pythagoras.o 

echo "[----- Run the program -----]"
./a.out

echo "[----- Program finished -----]"