; Jared De Los Santos
; CPSC 240-01
; jayred_dls@csu.fullerton.edu
; Midterm 2 Huron

STRING_LEN equ 256 ;max string length
extern printf
extern scanf
extern ispositivefloat
extern atof
extern output_area
extern output_error_message

global huron

section .data
    intro db "We find any area", 10, 0
    promptFirst db "Please enter the length of the first side: ", 0
    promptSecond db "Please enter the length of the second side: ", 0
    promptThird db "Please enter the length of the third side: ", 0
    displaySides db "The three sides are %.5lf  %.5lf   %.5lf", 10, 10, 0
    displaySemi db "The semi-peremeter is %.5lf ", 10, 0
    displayText db "The area will be returned to the driver.", 10, 0

    format db "%s", 0
    
section .bss
    array1: resq 1
    array2: resq 1
    array3: resq 1

section .text
huron:
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

    mov r14, 0 ;so we can reset to 0 if invalid input

    push qword -1
    push qword -2
;==============================================================;
firstside:
    mov rax, qword 0
    mov rdi, format
    mov rsi, promptFirst
    call printf
        
    mov rax, qword 0
    mov rdi, format
    mov rsi, rsp
    mov rax, 0
    call scanf

;===================float validation===========================;

    mov rdi, rsp
    mov rax, 0
    call ispositivefloat

    cmp rax, 0
    je firstside

;======================ascii to float==========================;

    mov rax, 1
    call atof

    movq [array1], xmm0
    addsd xmm15, [array1]

    

;===============================================================;
    mov rax, qword 0
    mov rdi, format
    mov rsi, promptSecond
    call printf
    
    mov rax, qword 0
    mov rdi, format
    mov rsi, rsp
    mov rax, 0
    call scanf

;===================float validation pt 2======================;

    mov rdi, rsp
    mov rax, 0
    call ispositivefloat

    cmp rax, 0

;======================ascii to float==========================;

    mov rax, 1
    call atof

    movq [array2], xmm0
    addsd xmm15, [array2]


;===============================================================;

    mov rax, qword 0
    mov rdi, format
    mov rsi, promptThird
    call printf
    
    mov rax, qword 0
    mov rdi, format
    mov rsi, rsp
    mov rax, 0
    call scanf

;===================float validation pt 3======================;

    mov rdi, rsp
    mov rax, 0
    call ispositivefloat

    cmp rax, 0

;======================ascii to float==========================;

    mov rax, 1
    call atof

    movq [array3], xmm0
    addsd xmm15, [array3]

    movsd xmm0, [array1]
    movsd xmm1, [array2]
    movsd xmm2, [array3]

    movsd xmm5, xmm0
    movsd xmm6, xmm1
    movsd xmm7, xmm2

    mov rdi, displaySides
    mov rax, 3
    call printf

    mov rax, 0x4000000000000000     ; 2.0
    movq xmm8, rax                

    divsd xmm15, xmm8 
    movsd xmm9, xmm15

    movsd xmm0, xmm9
    mov rdi, displaySemi
    mov rax, 1
    call printf          

    movsd xmm13, xmm15
    subsd xmm13, [array1]

    movsd xmm10, xmm15
    subsd xmm10, [array2]

    movsd xmm11, xmm15
    subsd xmm11, [array3]

    mulsd xmm15, xmm13
    mulsd xmm15, xmm10
    mulsd xmm15, xmm11

    ;if third side  <  first + second; jump to invalid
    ; 3 + 4 = 7
    ; 5 is third side
    ; 5 < 7
    addsd xmm5, xmm6
    ucomisd xmm7, xmm5
    jl invalid                     

    sqrtsd xmm15, xmm15   

    movsd xmm0, xmm15
    mov rax, 1
    mov rdi, format
    call output_area

    jmp endfunction

invalid:
    movq xmm15, r14
    call output_error_message
    
endfunction:

    mov rax, qword 0
    mov rdi, format
    mov rsi, displayText
    call printf

    movsd xmm0, xmm15
    pop rax
    pop rax


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

    pop rbp ; Restore rbp
    ret
    