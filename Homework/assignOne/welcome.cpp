/*
;********************************************************************************************
; Program name:          Hello World!                                 				        *
; Programming Language:  x86 Assembly                                                       *
; Program Description:   This program prompts user for name, title, and your favorite       *
                         hobby as part of a simulated conversation                          *
;********************************************************************************************
; Author Information:                                                                       *
; Name:         Jared De Los Santos                                          		        *
; Email:        jayred_dls@csu.fullerton.edu                               		            *
; Institution:  California State University Fullerton                                       *
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
;   Program name: Hello World!                                                              *
;   Programming languages: C++, x86, and one in bash            							*
;   Files in this program: hello.asm, welcome.cpp, run.sh								    *
;   					                    											    *
;                                                                                           *
;********************************************************************************************
; This File                                                                                 *
;    Name:      hello.asm                                                                   *
;    Purpose:   welcomes user with a string output, then calls hello.asm                    *
;                                                                                           *
;                                                                                           *
;********************************************************************************************
*/

#include <iostream>
//#include <stdio.h>
//#include <stdint.h>

using namespace std;

extern "C" char* start();

int main(int argc, char* argv[]){
    double return_code = -1;

    printf("\nWelcome to the classic 'Hello' program created by Jared De Los Santos\n");
    
    char* result = start();

    printf("See you later, %s", result); printf(".\n");
    printf("Take care. ");
    cout << return_code;
    printf(" will be returned to the OS.\n");

    return return_code;
}