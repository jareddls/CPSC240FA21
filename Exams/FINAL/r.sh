#!/bin/bash

#   Jared De Los Santos
#   CPSC240-01
#   jayred_dls@csu.fullerton.edu
#   Braker

rm *.o
rm *.out

echo "Assemble main.asm"
nasm -f elf64 -o main.o main.asm

echo "Assemble clock_speed.asm"
nasm -f elf64 -o clock_speed.o clock_speed.asm

echo "Assemble read_clock.asm"
nasm -f elf64 -o read_clock.o read_clock.asm

echo "Compile driver.c"
gcc -c -m64 -Wall -std=c11 -fno-pie -no-pie -o driver.o driver.c 

echo "Link the object files"
gcc -m64 -no-pie -o a.out -std=c11 driver.o read_clock.o main.o clock_speed.o

echo "[----- Run the program -----]"
./a.out

echo "[----- Program finished -----]"