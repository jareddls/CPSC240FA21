;   Jared De Los Santos
;   CPSC240-01
;   jayred_dls@csu.fullerton.edu
;   Electricity

extern printf
extern scanf
extern fgets
extern stdin
extern strlen

global ohm

MAX_STR_LEN equ 256 ;sets max string length

section .data

    floatFormat db "%lf", 0
    floatFinalFormat db "%.5lf", 0
    format db "%s", 0

    introduction db "This program will help you find the force.", 10, 0
    promptCharge1 db "Please enter the electrical charge on particle 1: ", 0
    promptCharge2 db "Please enter the electrical charge on particle 2: ", 0
    promptDistance db "Please enter the distance between the particles in meters: ", 0
    promptName db "Please enter your last name: ", 0
    promptTitle db "Please enter your title: ", 0
    
    displayForce db "Thank you. Your force is ", 0
    displayNeutron db " Neutrons.", 0

section .bss

    name resb MAX_STR_LEN
    title resb MAX_STR_LEN
    
section .text

ohm:

    ;back-up pushes
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

    ;shows 
    mov rax, qword 0
    mov rdi, format
    mov rsi, introduction
    call printf

        ;show prompt for name
    mov rax, qword 0
    mov rdi, format
    mov rsi, promptName
    call printf

    ;ask for input with fgets
    mov rax, qword 0
    mov rdi, name
    mov rsi, MAX_STR_LEN
    mov rdx, [stdin]
    call fgets

    ;gets rid of the newline that happens after fgets
    mov rax, qword 0
    mov rdi, name
    call strlen
    sub rax, 1 ; length stored in rax, go back 1 byte
    mov byte [name + rax], 0

    ;prompt for title
    mov rax, qword 0
    mov rdi, format
    mov rsi, promptTitle
    call printf
    
    ;user input
    mov rax, qword 0
    mov rdi, title
    mov rsi, MAX_STR_LEN
    mov rdx, [stdin]
    call fgets

    ;trailing newline gone
    mov rax, 0
    mov rdi, title
    call strlen
    sub rax, 1 ; length stored in rax, go back 1 byte
    mov byte [title + rax], 0
    
    ;creates space for the float numbers on the stack, pushes quadwords
    push qword -1
    push qword -2
    push qword -3 ;segfaults if only 3
    push qword -4

    ;asks for Q1 particle charge
    mov rax, qword 0
    mov rdi, format
    mov rsi, promptCharge1
    call printf

    ;user input
    mov rax, qword 0
    mov rdi, floatFormat
    mov rsi, rsp
    mov rdx, rsp
    call scanf
    movsd xmm15, [rsp]

    ;asks for Q2 particle charge
    mov rax, qword 0
    mov rdi, format
    mov rsi, promptCharge2
    call printf

    ;user input for Q2
    mov rax, qword 0
    mov rdi, floatFormat
    mov rsi, rsp
    mov rdx, rsp
    call scanf
    movsd xmm14, [rsp]

    ;asks for R distance
    mov rax, qword 0
    mov rdi, format
    mov rsi, promptDistance
    call printf
    
    ;user input
    mov rax, qword 0
    mov rdi, floatFormat
    mov rsi, rsp
    mov rdx, rsp
    call scanf
    movsd xmm13, [rsp]

    ;clean the stack by popping the same amount of pushes
    pop rax
    pop rax
    pop rax
    pop rax

    ;this is the constant K for the formula F = (K * Q1 * Q2) / r^2
    ;xmm15 = charge 1 
    ;xmm14 = charge 2
    ;xmm13 = distance
    mov rax, 0x4200BEC41C000000
    push rax
    movsd xmm12, [rsp]
    pop rax

    ;calculate k * q1
    mulsd xmm15, xmm12
    
    ;calculate xmm15 * q2
    mulsd xmm15, xmm14

    ;calculate xmm15 / r^2
    mulsd xmm13, xmm13
    divsd xmm15, xmm13

    ;show the first half of the message of the force
    mov rax, qword 0
    mov rdi, displayForce
    call printf

    mov rax, 1 ;telling scanf that we have a floating point argument
    mov rdi, floatFinalFormat ;final format to have 5 decimal values instead of more or less
    ;print the actual value 
    movsd xmm0, xmm15
    call printf

    ;print the second half
    mov rax, qword 0
    mov rdi, format
    mov rsi, displayNeutron
    call printf


    ; outputs the title in the C file
    mov rax, title
    ;restores the pushes
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
