; If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
; Find the sum of all the multiples of 3 or 5 below 1000.    
    
    extern  printf
    extern  exit

    SECTION .data
sum:        dd  0
sumMsg:     db  "The sum is %d.", 10, 0    

    SECTION .text

    global  main
main:
    mov     rcx, 999   ; count up to 1000
findFactors:
    ; test for factor of 3
    mov     rdx, 0
    mov     rax, rcx
    mov     rbx, 3
    div     rbx
    cmp     rdx, 0
    jz      incSum

    ; test for factor of 5
    mov     rdx, 0
    mov     rax, rcx
    mov     rbx, 5
    div     rbx
    cmp     rdx, 0
    jz      incSum
    loop    findFactors
    jmp     endMain
incSum:
    add     [sum], rcx
    loop    findFactors
endMain:
    ; print the result
    push    rbp
    mov     rdi, sumMsg
    mov     rsi, [sum]
    mov     rax, 0
    call    printf
    pop     rbp

    call    exit