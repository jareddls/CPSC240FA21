#include <stdio.h>

extern double hertz();

int main(int argc, char *argv[]){
    
    printf("\nWelcome to the Power Unlimited program by Jared De Los Santos\n");

    //links to assembly code
    double answer = hertz();

    //back out
    printf("\nThe main function received %.5lf and will keep it.\n", answer);
    printf("\n%s", "Next zero will be returned to the OS. Bye.\n\n");

    return 0;
}