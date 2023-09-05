#!/bin/bash

rm *.o
rm *.out

echo "Assemble the module travel.asm"
nasm -f elf64 -l travel.lis -o travel-o travel.asm

echo "Compile the C++ module main.cpp"
g++ -c -m64 -Wall -o main.o main.cpp -fno-pie -no-pie -std=c++17

echo "Link the two object files already created"
g++ -m64 -o main.out main.o travel.o -fno-pie -no-pie -std=c++17 -z noexecstack

echo "Run the program"
./main.out

echo "Bash should close"
