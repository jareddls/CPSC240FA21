//Jared De Los Santos
//CPSC240-01
//jayred_dls@csu.fullerton.edu
//Electricity




// includes printf
#include <stdio.h>

// for C, extern is only needed without the "C" directive
extern char* ohm();

int main()
{
    // Greet user 
    printf("Welcome to the High Voltage System Programming brought to you by Jared De Los Santos\n");

    // return value from x86, set name to the return value
    char* electricity = ohm();
    
    printf("\nGoodbye %s.", electricity);
    printf(" Have a nice research party.");
    printf("\nZero will be returned to the operating system.\n");

    return 0;
}
