    extern  printf
    extern  exit
    ; default rel

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
    ; mov     rax, [sum]
    ; push    rax
    ; push    sumMsg
    ; call    printf
    ; add     rsp, 8
    ; ret

    ; exit
    call    exit