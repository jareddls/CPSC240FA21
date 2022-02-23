// Jared De Los Santos
// CPSC 240-01
// jayred_dls@csu.fullerton.edu
// Midterm 2 Huron


#include <stdio.h>
#include <stdint.h>                                                                  
#include <ctime>
#include <cstring>


extern "C" void output_error_message();

void output_error_message(){
    printf("The inputted numbers do not form a triangle.  The area is set to zero.\n");
}
