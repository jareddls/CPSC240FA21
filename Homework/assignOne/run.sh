rm *.o
rm *.out

echo "Assemble hello.asm"
nasm -f elf64 -l hello.lis -o hello.o hello.asm

echo "Compile welcome.cpp"
g++ -c -m64 -Wall -std=c++17 -fno-pie -no-pie -o welcome.o welcome.cpp

echo "Link the object files"
g++ -m64 -std=c++17 -fno-pie -no-pie -o a.out hello.o welcome.o

echo "[----- Run the program -----]"
./a.out

echo "[----- Program finished -----]"