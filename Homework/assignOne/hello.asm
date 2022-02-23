;********************************************************************************************
; Program name:          Hello World!                                 						*
; Programming Language:  x86 Assembly                                                       *
; Program Description:   This program prompts user for name, title, and favorite            *
;                        book/movie/game as part of a simulated conversation                *
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
;   Program name: Hello World!			                                                    *
;   Programming languages: C++, X86, and one in bash			  						    *
;   Files in this program: hello.asm, welcome.cpp, run.sh									*
;   					                    												*
;                                                                                           *
;********************************************************************************************
; This File                                                                                 *
;    Name:      hello.asm                                                                   *
;    Purpose:   Prompt the user for an input, then output a response using the user's input *
;               Return to welcome.cpp with a return value of 0                              *
;                                                                                           *
;********************************************************************************************

extern printf ;prints strings to  console
extern scanf ;receives input from user
extern fgets ;same as above except to read a string with whitespace
extern stdin ;use along with fgets
extern strlen
global start
max_name_size equ 32
max_title_size equ 32

section .data
    ;layout for various responses/prompts for the conversations
    ;we are going to build

    ;db stands for define bytes
    ;0 at the end is to define a null-terminated string for c-strings
    ;10 is for a newline
    ;you don't need 10 if you are taking in an input from a user because
    ;you will take their "Enter" as the newline input
    text1 db "Please enter your whole name: ", 0
    text2 db "Enter your title (Mr, Ms, Programmer, etc.): ", 0
    text3_pt1 db "Hello %s ", 0
    text3_pt2 db "%s, what is your favorite hobby (one-word hobby)?  ", 0
    text4 db "%s sounds very cool!", 10, 0
    text5 db "This concludes the Hello program coded in x86_64 assembly.", 10, 0
    stringFormat db "%s", 0 ;%s means any string (formats into a string)
    align 64

section .bss
    ;variables for the user input
    ;we have 3 inputs we are asking for

    ;1) Entire name, which uses fgets to take a whitespace in for the whole name
    ;2) The title, like one you would have if you get married, or have a job, etc.
    ;3) Their favorite hobby, which we assume to be just a one-word, to practice scanf

    ;resb stands for reserve bytes
    name resb max_name_size    ;we reserve 32 bytes to assume 16 characters of space is the max value
    title resb max_title_size   ;might as well do the same for the rest
    response resb 16 ;same as above

section .text

start:
    ;back up the registers
    ;rbp and rsp are special purpose registers
    ;rbp points to the base of the current stack
    ;rsp points to the top of the current stack

    push rbp
    mov rbp, rsp
    push qword -1
    push rdx
    push rdi
    push rsi
    push r14
    pushf ;push flag register; what is the purpose?

    ;prompt the user for the name
    mov rdi, stringFormat ;copy rdi into stringFormat
    mov rsi, text1 ; copy rsi into text1
    mov rax, qword 0 ;calls sys_read to read user input
    call printf

    ;receive user's input and set to the variable "name"
    mov rdi, name
    mov rsi, max_name_size
    mov rdx, [stdin]
    mov rax, qword 0
    call fgets

    ;gets rid of the newline that happens after fgets
    mov rdi, name
    call strlen
    mov r14, rax
    mov [name + r14 - 1], byte 0

    ;prompt user for their title
    mov rdi, stringFormat
    mov rsi, text2
    mov rax, qword 0
    call printf

    ;receive user's input and set to variable "title"
    mov rdi, title
    mov rsi, max_title_size
    mov rdx, [stdin]
    mov rax, qword 0
    call fgets

    ;gets rid of the newline that happens after fgets
    mov rdi, title
    call strlen
    mov r14, rax
    mov [title + r14 - 1], byte 0

    ;reply to user with their title and then full name, then ask for their favorite hobby
    mov rdi, text3_pt1
    mov rsi, title
    mov rax, qword 0
    call printf

    mov rdi, text3_pt2
    mov rsi, name
    mov rax, qword 0
    call printf

    ;receive user input and set variable to 'response'
    mov rdi, stringFormat
    mov rsi, response
    mov rax, qword 0
    call scanf

    ;reply to user by telling them their hobby is cool using %s
    mov rdi, text4 ; %s sounds very cool
    mov rsi, response ; for the response to fill in the %s
    mov rax, qword 0
    call printf

    ;close the program by telling them that was the last of what the program has to ask
    mov rdi, stringFormat
    mov rdi, text5
    mov rax, qword 0
    call printf

    ;restore the registers
    mov rax, name		   ;name will be returned to c
	popf
    pop r14
    pop rsi
    pop rdi
    pop rdx
    pop r15 ;this is a random register (that can store a value) that we have to pop
            ;due to push qword 0
    pop rbp  
    
    ret