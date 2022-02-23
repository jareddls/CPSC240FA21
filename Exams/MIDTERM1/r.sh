#!/bin/bash

#   Jared De Los Santos
#   CPSC240-01
#   jayred_dls@csu.fullerton.edu
#   Electricity

rm *.o
rm *.out

echo "Assemble ohm.asm"
nasm -f elf64 -l ohm.lis -o ohm.o ohm.asm

echo "Compile faraday.c"
gcc -c -m64 -Wall -std=c11 -fno-pie -no-pie -o faraday.o faraday.c

echo "Link the object files"
gcc -m64 -std=c11 -fno-pie -no-pie -o a.out ohm.o faraday.o 

echo "[----- Run the program -----]"
./a.out

echo "[----- Program finished -----]"
