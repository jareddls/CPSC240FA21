#!/bin/bash

#Program: 
#Author: Jared De Los Santos

rm *.o
rm *.out

echo "Assemble triangle.asm"
nasm -f elf64 -l triangle.lis -o triangle.o triangle.asm

echo "Compile pythagoras.cpp"
g++ -c -m64 -Wall -std=c++17 -fno-pie -no-pie -o pythagoras.o pythagoras.cpp 

echo "Link the object files"
g++ -m64 -std=c++17 -fno-pie -no-pie -o a.out triangle.o pythagoras.o 

echo "[----- Run the program -----]"
./a.out

echo "[----- Program finished -----]"