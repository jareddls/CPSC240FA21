/*
;********************************************************************************************
; Program name:          Right Triangles                            						*
; Programming Language:  x86 Assembly                                                       *
; Program Description:   This program prompts user for name, title, and sides               *
;                        of a triangle that is separated by a whitespace                    *
;                        This finds the area and hypotenuse of the triangle                 *
;                        based on the two values you inputted                               *
;********************************************************************************************
; Author Information:                                                                       *
; Name:         Jared De Los Santos                                           		        *
; Email:        jayred_dls@csu.fullerton.edu                            		            *
; Institution:  California State University Fullerton                                     	*
; Course:       CPSC 240-01 Assembly Language                                               *
;                                                                                           *
;********************************************************************************************
; Copyright (C) 2021 Jared De Los Santos                                       			    *
; This program is free software: you can redistribute it and/or modify it under the terms   *
; of the GNU General Public License version 3 as published by the Free Software Foundation. *
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY  *
; without even the implied Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. *
; See the GNU General Public License for more details. A copy of the GNU General Public     *
; License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;                                                                                           *
;********************************************************************************************
; Program information                                                                       *
;   Program name: Right Triangles			                                                *
;   Programming languages: C++, X86, and one in bash			  						    *
;   Files in this program: triangle.asm, pythagoras.cpp, run.sh								*
;   					                    												*
;                                                                                           *
;********************************************************************************************
; This File                                                                                 *
;    Name:      triangle.asm                                                                *
;    Purpose:   Prompt the user for two inputs separated by a whitespace, then output       *
;               an area and hypotenuse                                                      *
;               Return to pythagoras.cpp with a return value of 0                           *
;                                                                                           *
;********************************************************************************************
*/

#include <iostream>
using namespace std;

extern "C" double triangle();

int main(int argc, char *argv[]){
    double answer = 0;

    printf("\nWelcome to the classic 'Right Triangles' program created by Jared De Los Santos\n");
    printf("If errors are discovered please report them to Jared De Los Santos at jayred_dls@csu.fullerton.edu for a quick fix.\n");

    //links to assembly code
    answer = triangle();

    //back out
    printf("The main function received this number %.5lf and plans to keep it.\n", answer);
    printf("\n%s", "An integer zero will be returned to the operating system. Bye.\n");
    cout << endl;

    return 0;
}