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


STRING_LEN equ 256 ;max string length
extern printf
extern scanf
extern fgets
extern stdin
extern strlen

global triangle

section .data
    floatFormat db "%lf", 0
    twoFloatFormat db "%lf %lf", 0
    space db " ", 0
    invalid db "A negative number was detected, please input positive floats", 10, 0
    format db "%s", 0
    
    promptName db "Please enter your last name: ", 0
    promptTitle db "Please enter your title: ", 0
    promptSides db "Please enter the sides of your triangle separated by a space: ", 0

    displayArea db "The area of this triangle is ", 0
    displayHypotenuse db "The hypotenuse is ", 0
    squareUnits db " square units.", 10, 0
    units db " units.", 10, 0
    exitMessage db "Please enjoy your triangles ", 0


section .bss
    name resb STRING_LEN
    title resb STRING_LEN

section .text
triangle:
    push rbp ; Save base pointer to stack
    mov rbp, rsp ; Move rsp into rbp

    push rdi ; Backup rdi
    push rsi ; Backup rsi
    push rdx ; Backup rdx
    push rcx ; Backup rcx
    push r8  ; Backup r8
    push r9 ; Backup r9
    push r10 ; Backup r10
    push r11 ; Backup r11
    push r12 ; Backup r12
    push r13 ; Backup r13
    push r14 ; Backup r14
    push r15 ; Backup r15
    push rbx ; Backup rbx
    pushf ; Backup rflags

    ;shows the prompt for name
    mov rax, qword 0
    mov rdi, format; load format into rdi
    mov rsi, promptName ; load message into rdi
    call printf

    ;make user input using fgets
    mov rax, qword 0
    mov rdi, name
    mov rsi, STRING_LEN ; string length
    mov rdx, [stdin] ; pass in value of stdin
    call fgets

    ;remove trailing newline from fgets
    mov rax, qword 0
    mov rdi, name
    call strlen
    sub rax, 1 ;the length stored in rax, and we go back 1 byte
    mov byte [name + rax], 0

    ;shows the prompt for title
    mov rax, qword 0
    mov rdi, format
    mov rsi, promptTitle
    call printf

    ;make user input using fgets for title
    mov rax, qword 0
    mov rdi, title
    mov rsi, STRING_LEN
    mov rdx, [stdin]
    call fgets

    ;remove trailing newline from fgets
    mov rax, qword 0
    mov rdi, title
    call strlen
    sub rax, 1
    mov byte [title + rax], 0

    ;NOW for the new test case for assignment 3
    ;in the inputs are negative, we restart here
    restart:
    mov rax, qword 0
    mov rdi, format
    mov rsi, promptSides
    call printf

    ;let's make space for 2 float numbers by pushing 2 quadwords on the stack
    push qword -1
    push qword -2

    mov rax, qword 0
    mov rdi, twoFloatFormat
    mov rsi, rsp ; rsi points to first quadword on the stack
    mov rdx, rsp
    add rdx, 8 ; lets rdx point to 2nd quadword ons tack
    call scanf

    movsd xmm15, [rsp]  ;first input into xmm15
    movsd xmm14, [rsp+8]    ;move 2nd input into xmm14, at the address of rsp+8

    ;pop the same amount you pushed 
    pop rax
    pop rax

    ;zero out xmm11 fastest way, by using itself and sets it equal to 0
    xorpd xmm11, xmm11

    ;check if xmm15 (first input) is less than xmm11 (0)
    ucomisd xmm15, xmm11
    jb negative ;jump to the "negative: " block

    ;check if xmm14 (second input) is less than xmm11 (0)
    ucomisd xmm14, xmm11
    jb negative

    mov rax, 0x4000000000000000 ;0x4000000000000000 is the value 2.0 and we put it into rax
    push rax ; push rax to the top of the stack
    movsd xmm13, [rsp] ;move value at the top of the stack (rsp, which in this case is 2.0), into xmm13
    pop rax ; pop rax to return

    ;backup for the value because i know xmm does some weird flushing of values
    movsd xmm12, xmm15 ; xmm12 = first input

    ;computations
    mulsd xmm12, xmm14 ; first input *= second input
    divsd xmm12, xmm13 ; first input /= 2.0 
    ;after the two steps above, we will have obtained the area in xmm12

    mov rax, qword 0
    mov rdi, displayArea ; "The area of this triangle is "
    call printf

    mov rax, 1 ;tell printf we have a float argument
    mov rdi, floatFormat ; "%lf"
    movsd xmm0, xmm12 ; area is put into xmm0 so that we can print
    call printf

    mov rax, qword 0
    mov rdi, format
    mov rsi, squareUnits ; " square units."
    call printf

    ;computation for hypotenuse
    mulsd xmm15, xmm15 ; xmm15^2
    mulsd xmm14, xmm14 ; xmm14 *= xmm14 (xmm14^2)

    addsd xmm14, xmm15 ; xmm14 += xmm15 
    sqrtsd xmm14, xmm14 ; xmm14 = sqrt(xmm14)

    mov rax, qword 0
    mov rdi, displayHypotenuse ;"The hypotenuse is "
    call printf

    mov rax, 1
    mov rdi, floatFormat
    movsd xmm0, xmm14 ;xmm0 = hypotenuse
    call printf
    
    mov rax, qword 0
    mov rdi, format
    mov rsi, units ; " units."
    call printf

    mov rax, qword 0
    mov rdi, format
    mov rsi, exitMessage ; "Please enjoy your triangles"
    call printf

    mov rax, qword 0
    mov rdi, format
    mov rsi, title  ;load the title from the user input
    call printf

    mov rax, qword 0
    mov rdi, format
    mov rsi, space ; load space into rdi
    call printf

    mov rax, qword 0
    mov rdi, format
    mov rsi, name ; load the name from the user input
    call printf
    
    ;move final value into xmm0 to be returned
    ;
    movsd xmm0, xmm14

    ;jump to the end block
    jmp end

    negative:
    mov rax, qword 0
    mov rdi, format
    mov rsi, invalid ;"A negative number was detected, please input positive floats"
    call printf
    jmp restart

    end:
    popf ; Restore rflags
    pop rbx ; Restore rbx
    pop r15 ; Restore r15
    pop r14 ; Restore r14
    pop r13 ; Restore r13
    pop r12 ; Restore r12
    pop r11 ; Restore r11
    pop r10 ; Restore r10
    pop r9 ; Restore r9
    pop r8 ; Restore r8
    pop rcx ; Restore rcx
    pop rdx ; Restore rdx
    pop rsi ; Restore rsi
    pop rdi ; Restore rdi

    pop rbp ; Restore rbp
    ret
    