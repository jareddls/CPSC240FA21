#!/bin/bash

#Program: 
#Author: Jared De Los Santos

rm *.o
rm *.out

echo "Assemble hertz.asm"
nasm -f elf64 -l hertz.lis -o hertz.o hertz.asm

echo "Compile maxwell.c"
gcc -c -m64 -Wall -std=c11 -fno-pie -no-pie -o maxwell.o maxwell.c 

echo "Compile isfloat.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -o isfloat.o isfloat.cpp -std=c++17

echo "Link the object files"
gcc -m64 -std=c11 -fno-pie -no-pie -o a.out hertz.o maxwell.o isfloat.o

echo "[----- Run the program -----]"
./a.out

echo "[----- Program finished -----]"