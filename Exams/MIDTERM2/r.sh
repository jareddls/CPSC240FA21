# Jared De Los Santos
# CPSC 240-01
# jayred_dls@csu.fullerton.edu
# Midterm 2 Huron


rm *.o
rm *.out

echo "Assemble huron.asm"
nasm -f elf64 -l huron.lis -o huron.o huron.asm

echo "Compile triangle.c"
gcc -c -m64 -Wall -std=c11 -fno-pie -no-pie -o triangle.o triangle.c 

echo "Compile ispositivefloat.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -o ispositivefloat.o ispositivefloat.cpp -std=c++17

echo "Compile output_area.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -o output_area.o output_area.cpp -std=c++17

echo "Compile output_error_message.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -o output_error_message.o output_error_message.cpp -std=c++17

echo "Link the object files"
gcc -m64 -std=c11 -fno-pie -no-pie -o a.out huron.o triangle.o ispositivefloat.o output_area.o output_error_message.o

echo "[----- Run the program -----]"
./a.out

echo "[----- Program finished -----]"