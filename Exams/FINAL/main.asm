; #   Jared De Los Santos
; #   CPSC240-01
; #   jayred_dls@csu.fullerton.edu
; #   Braker

extern printf
extern scanf
extern atof
extern gettime
extern clock_speed

global newtons

section .data
    floatFormat db "%lf", 0
    floatFinalFormat db "%.8lf", 0
    space db " ", 10, 0
    format db "%s", 0
    welcome db "Welcome to the Santos Braking Program.", 10, 0

    initialClock db "This is test of initial: %ld", 10, 0
    finalClock db "This is test of final save: %ld", 10, 0

    promptMass db "Please enter the mass of the moving vechile (Kg): ", 0
    promptVelocity db "Please enter the velocity of the vehicle (meters per second): ", 0
    promptDistance db "Please enter the distance (meters) required for a complete stop: ", 0
    promptFrequency db "Please enter the cpu frequency (GHz): ", 0

    displayFrequency db "The frequency (GHz) of the processor in machine is ", 0
    displayForce db "The required braking force is ", 0
    displayForce2 db " Newtons.", 10, 0

    elapsedTics db "The computation required %ld tics or %.1lf nanosec.", 10, 0
    displayComputation db "The computation required ", 0
    displayComputation2 db " tics or ", 0
    displayComputation3 db " nanosec."
    
section .bss

section .text
newtons:
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
    
    push qword -1
    push qword -2
    push qword -3
    push qword -4
beginning:
    ;Welcome to the Santos Braking Program
    mov rax, qword 0
    mov rdi, format
    mov rsi, welcome
    call printf

    ;The frequency (GHz) of the processor in machine is xxxxx
    mov rax, qword 0
    mov rdi, format
    mov rsi, displayFrequency
    call printf

    mov rax, 1
    call clock_speed
    mov rdi, floatFinalFormat
    movsd xmm8, xmm0
    call printf
    ; mov rax, 1
    ; call clock_speed
    ; call printf

    mov rax, qword 0
    mov rdi, format
    mov rsi, space
    call printf
prompt:
    ;Please enter the mass of the moving vechile (Kg): 
    mov rax, qword 0
    mov rdi, format
    mov rsi, promptMass
    call printf

    mov rax, qword 0
    mov rdi, floatFormat
    mov rsi, rsp
    mov rdx, rsp
    call scanf
    movsd xmm15, [rsp]  ;m

    ;Please enter the velocity of the vehicle (meters per second): 
    mov rax, qword 0
    mov rdi, format
    mov rsi, promptVelocity
    call printf

    mov rax, qword 0
    mov rdi, floatFormat
    mov rsi, rsp
    mov rdx, rsp
    call scanf
    movsd xmm14, [rsp]  ;v

    ;Please enter the distance (meters) required for a complete stop: 
    mov rax, qword 0
    mov rdi, format
    mov rsi, promptDistance
    call printf

    mov rax, qword 0
    mov rdi, floatFormat
    mov rsi, rsp
    mov rdx, rsp
    call scanf
    movsd xmm13, [rsp]  ;d

   ;initial cpu clock reading 
    mov rax, 0
    call gettime
    mov r14, rax

    mov rax, 0
    mov rdi, initialClock
    mov rsi, r14
    ;call printf    ;if you want to read initial clock before calculation


; F   =  0.5  x  m  x  v  x  v / d
;   MULTIPLYING BY 0.5 IS SAME AS DIVIDING BY 2

    ;0.5
    mov rax, 0x4000000000000000
    push rax
    movsd xmm12, [rsp]
    pop rax

    ;m
    movsd xmm9, xmm15

    ;v^2
    movsd xmm10, xmm14
    mulsd xmm10, xmm10

    ;d
    movsd xmm11, xmm13

    mulsd xmm9, xmm10
    divsd xmm9, xmm12
    divsd xmm9, xmm11

    movsd xmm7, xmm9
    
    ;cpu clock reading
    mov rax, 0
    call gettime
    mov r15, rax

    mov rax, 0
    mov rdi, finalClock
    mov rsi, r15
    ;call printf    ;if you want to print out FINAL clock after calculation

answers:

    ;The required braking force is
    mov rax, qword 0
    mov rdi, displayForce
    call printf

    mov rax, 1
    mov rdi, floatFinalFormat
    movsd xmm0, xmm7
    call printf

    mov rax, qword 0
    mov rdi, format
    mov rsi, displayForce2
    call printf

    mov rax, qword 0
    mov rdi, format
    mov rsi, promptFrequency
    call printf

    mov rax, qword 0
    mov rdi, floatFormat
    mov rsi, rsp
    mov rdx, rsp
    call scanf
    movsd xmm3, [rsp]

    ;according to some research done online, nanosecond conversion is 
    ;(tics / frequency) * 1 billion

    ;elapsed time computation
    cvtsi2sd xmm5, r15 ;final clock to float
    cvtsi2sd xmm4, r14 ;initial clock to float
    subsd xmm5, xmm4
    cvtsd2si r15, xmm5

    mov rax, 0x41cdcd6500000000 ;1 billion in IEEE-754
    movq xmm6, rax              ;copies 1 billion as float

    divsd xmm5, xmm3
    mulsd xmm5, xmm6

    mov rax, 1
    mov rdi, elapsedTics
    mov rsi, r15        ;%ld holds the tics
    movsd xmm0, xmm5    ;%lf holds final answer
    call printf

endfunction:
    pop rax
    pop rax
    pop rax
    pop rax
    movsd xmm0, xmm5

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
    