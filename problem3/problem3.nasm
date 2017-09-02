; The prime factors of 13195 are 5, 7, 13 and 29.
; What is the largest prime factor of the number 600,851,475,143 ?

;------------------------------------------------------------------------------
; I had a lot of fun with this one. I learned a lot about x64 programming
; e.g. issues using the stack for pushed parameters, though I removed that
; later for simplicity; why I used + 4 in stack frame references with 32-bit,
; stack alignment, etc.; in short, assembly and cpu architecture makes a bit
; more sense now.
;
; I also got a lot of practice in with gdb debugging this and am much quicker.
; I was getting quite frustrated at the end until I realized I had typo'd the
; number I was supposed to be testing the prime factor for.
;
; I can think of at least one optimization for the CPU by saving the last
; quotient from testOverLimit. There's probably a better algorithm overall
; for this, but I'm not mainly a math guy.
;
; % time ./problem3
; The largest factor is: 6857.
; ./problem3  0.13s user 0.00s system 99% cpu 0.126 total
;------------------------------------------------------------------------------


extern printf, exit

SECTION .data
target:     dq              600851475143
primes:     times 5000 dq   0
factors:    times 5000 dq   0
pCount:     dq              1
fCount:     dq              0
overLimit:  dq              0
facMsg:     db              "The largest factor is: %d.", 10, 0


SECTION .text
global  main

main:
    mov     QWORD [primes], 2       ; primes are natural #'s > 1
.searchPrimes:
    call    getPrime
    call    testFactor
    call    testOverLimit
    cmp     QWORD [overLimit], 0    ; 0 == false, continue finding factors
    je      .searchPrimes

    ; print last factor and exit
    mov     rax, factors
    mov     rdi, facMsg
    mov     rbx, [fCount]
    mov     rsi, [rax + ((rbx - 1) * 8)]
    mov     rbx, 0
    mov     rax, 0
    call    printf
    call    exit

; provide a starting number and incrementally test new numbers until a new
; prime is found, adding it to the array of primes
getPrime:
    push    rsi
    push    r8
    push    r9
    push    rax
    push    rbx

    mov     rsi, primes
    mov     r8, [pCount]
    mov     rax, [rsi + ((r8 - 1) * 8)]     ; rax contains last found prime
.testPrime:
    inc     rax             ; test if next number is prime
    mov     rbx, rax
.nextDivisor:
    dec     rbx
    cmp     rbx, 1          ; if there's a remainder and rbx == 1, it's prime
    je      .isPrime
    mov     rdx, 0          ; zero out rdx
    mov     r9, rax         ; save our prime
    div     rbx             ; divide prime
    mov     rax, r9         ; restore our prime
    cmp     rdx, 0
    je      .testPrime      ; not prime if no remainder, test next number
    jmp     .nextDivisor    ; otherwise keep testing w/ smaller divisor
.isPrime:
    mov     [rsi + (r8 * 8)], rax ; store prime in next array element
    inc     QWORD [pCount]        ; pCount is larger

    pop     rbx
    pop     rax
    pop     r9
    pop     r8
    pop     rsi
    ret


; given a number, test if it is a factor of the target number, adding it to
; the array of factors
testFactor:
    push    rax
    push    rbx
    push    rdx
    push    rsi
    push    r8

    mov     rsi, primes
    mov     r8, [pCount]                    ; prime count into r8
    mov     rdx, 0
    mov     rax, QWORD [target]
    mov     rbx, [rsi + ((r8 - 1) * 8)]     ; mov last prime into rbx

    div     rbx
    cmp     rdx, 0
    jne     .endTest

    mov     rsi, factors
    mov     r8, [fCount]
    mov     [rsi + (r8 * 8)], rbx
    inc     QWORD [fCount]

.endTest:
    pop     r8
    pop     rsi
    pop     rdx
    pop     rbx
    pop     rax
    ret

; test if the product of each known factor is greater than the target number
testOverLimit:
    push    rax
    push    rbx
    push    rcx
    push    rsi

    mov     rsi, factors
    mov     rcx, 0
.doTest:
    cmp     rcx, [fCount]
    je      .notLimit               ; if rcx is at our count of factors, stop
    mov     rax, [rsi + (rcx * 8)]
    inc     rcx
    mov     rbx, [rsi + (rcx * 8)]
    mul     rbx
    cmp     rax, target
    jge     .hitLimit
    jmp     .doTest
.hitLimit:
    mov     QWORD [overLimit], 1    ; true, limit hit
    jmp     .stopTest
.notLimit:
    mov     QWORD [overLimit], 0    ; false, limit not hit
.stopTest:
    pop     rsi
    pop     rcx
    pop     rbx
    pop     rax
    ret
