#!/bin/bash

#Program: 
#Author: Jared De Los Santos

rm *.o
rm *.out

echo "Assemble hertz.asm"
nasm -f elf64 -l hertz.lis -o hertz.o hertz.asm -g -gdwarf

echo "Compile maxwell.c"
gcc -c -m64 -Wall -std=c11 -fno-pie -no-pie -o maxwell.o maxwell.c -g

echo "Compile isfloat.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -o isfloat.o isfloat.cpp -std=c++17 -g

echo "Link the object files"
gcc -m64 -std=c11 -fno-pie -no-pie -o a.out hertz.o maxwell.o isfloat.o -g

echo "[----- Run the program -----]"
gdb ./a.out

echo "[----- Program finished -----]"