/*

Author information
 Author name: Jared De Los Santos
 Author email: jayred_dls@csu.fullerton.edu

This file
 Program name: isfloat
 File name: isfloat.cpp


Program name: "isfloat".  This is a single function distributed without accompanying software.  This function scans a      *
char array seeking to confirm that all characters in the array are in the range of ascii characters '0' .. '9'.  Further-  *
more, this function confirms that there is exactly one decimal point in the string.  IF both conditions are true then a    *
boolean true is returned, otherwise a boolean false is returned.  Copyright (C) 2020 Floyd Holliday                        *

This is a library function distributed without accompanying software. 

 This is a library function.  It does not belong to any one specific application.  The function is available for inclusion 
 in other applications.  If it is included in another application and there are no modifications made to the executing 
 statements in this file then do not modify the license and do not modify any part of this file; use it as is.
 Language: C++
 Max page width: 132 columns
 Optimal print specification: monospace, 132 columns, 8½x11 paper
 Testing: This function was tested successfully on a Linux platform derived from Ubuntu.
 Compile: g++ -c -m64 -Wall -fno-pie -no-pie -o isfloat.o isfloat.cpp -std=c++17
 Classification: Library

*/
#include <cstdlib>
#include <ctype.h>

using namespace std;

extern "C" bool isfloat(char [ ]);

bool isfloat(char w[ ])
{   bool result = true;
    bool onepoint = false;
    int start = 0;
    if (w[0] == '-' || w[0] == '+') start = 1;
    unsigned long int k = start;
    while (!(w[k] == '\0') && result )
    {    if (w[k] == '.' && !onepoint) 
               onepoint = true;
         else
               result = result && isdigit(w[k]) ; 
         k++;
     }
     return result && onepoint;
}