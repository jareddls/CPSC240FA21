//Jared De Los Santos
//CPSC 240-01
//jayred_dls@csu.fullerton.edu
// Midterm 2 Huron
#include <stdio.h>

extern double huron();

int main()
{
	printf("\n%s","Welcome to Area of Triangles by Jared De Los Santos\n\n");

	// Call assembly area function.
	double answer = huron();

	// Print out area received from area() in 16 bit Hexidecimal.
	printf("\nThe main program recieved this number %.5lf and will keep it.", answer);

	// Prints out goodbye message.
	printf("\n\n%s","I hope you enjoyed this triangle program. A zero will be sent to the OS. Bye.\n\n");
	return 0;
}