// #   Jared De Los Santos
// #   CPSC240-01
// #   jayred_dls@csu.fullerton.edu
// #   Braker

#include <stdio.h>

extern double newtons();

int main(int argc, char *argv[]){
    
    printf("\nThis is Final exam by Jared De Los Santos.\n");

    //links to assembly code
    double answer = newtons();

    //back out
    printf("\nThe main function received %.1lf and will just keep it.\n", answer);
    printf("\n%s", "Have a nice day.\n\n");

    return 0;
}