; Each new term in the Fibonacci sequence is generated by adding the previous two terms. By starting with 1 and 2, the first 10 terms will be:
; 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
; By considering the terms in the Fibonacci sequence whose values do not exceed four million, find the sum of the even-valued terms.

extern printf, exit

SECTION .data
sum:        dd      0
sumMsg:     db      "The sum was %d.", 10, 0

SECTION .text
global main

main:
    mov     rax, 1
    mov     rbx, 2
calculateFib:
    add     rax, rbx
    mov     rdx, rax
    mov     rax, rbx
    mov     rbx, rdx

    ; test if we've exceeded four million and exit if so
    cmp     rax, 4000000
    jg      endFib

    ; test if even, add to sum if it is
    mov     rdx, 0
    push    rbx
    push    rax
    mov     rbx, 2
    div     rbx
    pop     rax
    pop     rbx
    cmp     rdx, 0
    je      sumFib

    jmp     calculateFib
sumFib:
    add     [sum], rax
    jmp     calculateFib
endFib:
    ; print our sum
    mov     rdi, sumMsg
    mov     rsi, [sum]
    mov     rax, 0
    call    printf
    call    exit