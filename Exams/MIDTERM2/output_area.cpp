// Jared De Los Santos
// CPSC 240-01
// jayred_dls@csu.fullerton.edu
// Midterm 2 Huron

#include <stdio.h>
#include <stdint.h>                                                                  
#include <ctime>
#include <cstring>


extern "C" void output_area(double side);

void output_area(double side){
    printf("%s %.5lf", "The area of the triangle is ", side);
    printf("%s", ". Have a nice day.\n");
}

