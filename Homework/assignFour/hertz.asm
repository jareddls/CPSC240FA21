;********************************************************************************************
; Program name:          Power Unlimited                            						*
; Programming Language:  x86 Assembly                                                       *
; Program Description:   This program prompts computes an equation for an EE major          *
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
;   Program name: Power Unlimited			                                                *
;   Programming languages: C, X86, and one in bash			  					     	    *
;   Files in this program: hertz.asm, maxwell.c, r.sh, rg.sh								*
;   					                    												*
;                                                                                           *
;********************************************************************************************
; This File                                                                                 *
;    Name:      hertz.asm                                                                   *
;    Purpose:   Prompt the user for two inputs separated by a whitespace, then output       *
;               an area and hypotenuse                                                      *
;               Return to maxwell.c with a return value of 0                           *
;                                                                                           *
;********************************************************************************************


STRING_LEN equ 256 ;max string length
extern printf
extern scanf
extern fgets
extern stdin
extern strlen
extern isfloat
extern atof

global hertz

section .data
    floatFormat db "%lf", 0
    floatFinalFormat db "%.5lf", 0
    space db " ", 0
    invalid db "Invalid inpuit detected. You may run this program again.", 0
    format db "%s", 0
    welcome db "Welcome ", 0
    finishWelcome db ". ", 10, 0

    promptName db "Please enter your name. You choose the format of your name: ", 0
    promptResist db "Please enter the resistance in your circuit: ", 0
    promptFlow db "Please enter the current flow in this circuit: ", 0
    
    displayFirst db "We will find your power.", 10, 0
    displayThanks db "Thank you ", 0
    displayPower db ". Your power consumption is ", 0
    watts db " watts.", 10, 0
    
section .bss
    pname: resb STRING_LEN
    array1: resq 1
    array2: resq 1

section .text
hertz:
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

    ;flag
    mov r14, 0xBFF0000000000000 ;so we can reset to 0 if invalid input
    ;show text one (displayFirst)
    mov rax, qword 0
    mov rdi, format
    mov rsi, displayFirst
    call printf

    ;display the prompt
    mov rax, qword 0
    mov rdi, format
    mov rsi, promptName
    call printf
    
    ;take in the prompt (user input)
    mov rax, qword 0
    mov rdi, pname
    mov rsi, STRING_LEN
    mov rdx, [stdin]
    call fgets

    ;remove trailing newline
    mov rax, qword 0
    mov rdi, pname
    call strlen
    sub rax, 1
    mov byte [pname + rax], 0

    mov rax, qword 0
    mov rdi, format
    mov rsi, welcome
    call printf
    
    mov rax, qword 0
    mov rdi, format
    mov rsi, pname
    call printf

    mov rax, qword 0
    mov rdi, format
    mov rsi, finishWelcome
    call printf

    ;restart (if negative not allowed, but i think it is)
    ;space for two floats
    push qword -1
    push qword -2
;==============================================================;
    mov rax, qword 0
    mov rdi, format
    mov rsi, promptResist
    call printf
        
    mov rax, qword 0
    mov rdi, format
    mov rsi, rsp
    mov rax, 0
    call scanf

;===================float validation===========================;

    mov rdi, rsp
    mov rax, 0
    call isfloat

    cmp rax, 0
    je invalid_input

;======================ascii to float==========================;

    mov rax, 1
    call atof

    movq [array1 + 8], xmm0
    addsd xmm15, [array1 + 8]

    

;===============================================================;

    mov rax, qword 0
    mov rdi, format
    mov rsi, promptFlow
    call printf
    
    mov rax, qword 0
    mov rdi, format
    mov rsi, rsp
    mov rax, 0
    call scanf

;===================float validation pt 2======================;

    mov rdi, rsp
    mov rax, 0
    call isfloat

    cmp rax, 0
    je invalid_input

;======================ascii to float==========================;

    mov rax, 1
    call atof

    movq [array2 + 8], xmm0
    addsd xmm14, [array2 + 8]


;===============================================================;

    jmp valid_input

invalid_input:
    mov rax, 0
    mov rdi, format
    mov rsi, invalid
    call printf

    movq xmm15, r14
    
    jmp endfunction

;===============================================================;

valid_input:

    ; P = flow^2 * resistance
    ; xmm15 = resistance
    ; xmm14 = flow
    mulsd xmm14, xmm14
    mulsd xmm15, xmm14

    mov rax, qword 0
    mov rdi, format
    mov rsi, displayThanks
    call printf

    mov rax, qword 0
    mov rdi, format
    mov rsi, pname
    call printf

    mov rax, qword 0
    mov rdi, displayPower
    call printf

    mov rax, 1
    mov rdi, floatFinalFormat
    movsd xmm0, xmm15
    call printf

    mov rax, qword 0
    mov rdi, format
    mov rsi, watts
    call printf


endfunction:
    movsd xmm0, xmm15
    pop rax
    pop rax

    ;end:
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
    