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

extern printf       ;printing strings 
extern scanf        ;receiving input from user
extern fgets        ;inputs that INCLUDE whitespace
extern stdin        ;required with fgets
extern strlen       ;gets rid of the extra line from fgets
global triangle     ;makes the function callable by other linked files (like our cpp file)
max_name_size equ 32
max_title_size equ 32
max_float_size equ 64



;=============================================.data section for our messages================================================================

section .data 

    inputName db "Please enter your last name: ", 0
    inputTitle db "Please enter your title (Mr, Ms, Programmer, etc.): " , 0
    inputSides db "Please enter the sides of your triangle separated by ws: ", 0

    areaOutput db "The area of this triangle is %.5lf square units. ", 10, 0
    lengthOutput db "The length of the hypotenuse is %.5lf units." , 10, 0

    goodbye db "Please enjoy your triangles, %s", 0
    goodbye2 db " %s!", 10, 0

    stringFormat db "%s", 0 
    floatFormat db "%.5lf", 0
    twoFloatFormat db "%lf %lf", 0

    align 64

;=============================================.bss section for our pointers================================================================

section .bss
    name resb max_name_size
    title resb max_title_size
    float_result resb max_float_size

;=============================================Begin application===============================================================

section .text

triangle:

    ;Back up the GPRs
    push rbp
    mov rbp, rsp
    push rdi
    push rsi
    push rdx
    push rcx
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    push rbx
    pushf

    ;Backing up the reg
    push    qword 0

    ;prompt the user for the name
    mov     rax, qword 0        ; i think i'll just start moving rax, qword 0 first since it looks cleaner
    mov     rdi, stringFormat   ; "%s"
    mov     rsi, inputName      ; please enter your last name
    call    printf

    ;receive user's input and set to the variable "name"
    mov     rax, qword 0
    mov     rdi, name           ; user's last name with whitespaces since its possible to have multi-word
                                ; last names
    mov     rsi, max_name_size
    mov     rdx, [stdin]
    call    fgets

    ;gets rid of the newline that happens after fgets
    mov rdi, name
    call strlen
    mov r14, rax
    mov [name + r14 - 1], byte 0

    ;prompt user for their title
    mov     rax, qword 0
    mov     rdi, stringFormat   ; "%s"
    mov     rsi, inputTitle    ; please enter your title
    call    printf

    ;receive user's input and set to variable "title"
    mov     rax, qword 0
    mov     rdi, title        ; user's title
    mov     rsi, max_title_size
    mov     rdx, [stdin]
    call    fgets

    ;gets rid of the newline that happens after fgets
    mov rdi, title
    call strlen
    mov r14, rax
    mov [title + r14 - 1], byte 0

    ;prompt for the triangle separated by ws
    mov     rax, 0
    mov     rdi, stringFormat
    mov     rsi, inputSides
    call    printf

    ;receive user's input for the sides of the triangle
    push    qword 99

    push    qword -1
    push    qword -2

    mov     rax, 0
    mov     rdi, twoFloatFormat
    mov     rsi, rsp
    mov     rdx, rsp
    add     rdx, 8
    call    scanf

    movsd   xmm15, [rsp]
    movsd   xmm13, [rsp]
    movsd   xmm11, [rsp+8]
    movsd   xmm14, [rsp+8]

    pop     rax
    pop     rax
    
    ;putting the value 2.0 on to the XMM12 for division

    mov     rax, 0x4000000000000000
    push    rax
    movsd   xmm12, [rsp]
    pop     rax

    ;Calculate the area of the triangle

    mulsd   xmm15, xmm11
    divsd   xmm15, xmm12

    ;Output the area of the triangle message

    movsd   xmm0, xmm15
    mov     rdi, areaOutput ;dest, src and printf's requirement is (rdi, rsi) typically
    mov     rax, 1
    call    printf

    ;Calculate the length hypotenuse of the triangle

    mulsd   xmm13, xmm13
    mulsd   xmm14, xmm14
    addsd   xmm13, xmm14
    sqrtsd  xmm2, xmm13
    movsd   xmm10, xmm2

    ;Output the length hypotenuse the triangle message

    movsd   xmm0, xmm2
    mov     rdi,  lengthOutput
    mov     rax,  1
    mov     r13, rax
    call    printf

    ;Show the goodbye message

    mov     rax, qword 0
    mov     rdi, goodbye   
    mov     rsi, title        
    call    printf

    mov     rax, qword 0
    mov     rdi, goodbye2   
    mov     rsi, name       
    call    printf

    ; mov     rax, qword 0
    ; mov     rdi, stringFormat   ; "%s"
    ; mov     rsi, goodbye        ; goodbye
    ; call    printf

    ; mov     rax, qword 0                           
    ; mov     rdi, stringFormat                             
    ; mov     rsi, title
    ; call    printf

    ; mov     rax, qword 0
    ; mov     rdi, stringFormat              
    ; mov     rsi,name
    ; call    printf

    ;Keep the length of the triangle and output it on to the global function triangle.
    movsd   xmm0, xmm10

    pop     rax
    pop     rax

    mov rax, float_result
    ;pop the system stack
    popf          
    pop rbx                                                                                            
    pop r15                                                     
    pop r14                                                      
    pop r13                                                      
    pop r12                                                      
    pop r11                                                     
    pop r10                                                     
    pop r9                                                      
    pop r8                                                      
    pop rcx                                                     
    pop rdx                                                     
    pop rsi                                                     
    pop rdi                                                     
    pop rbp

    ret
