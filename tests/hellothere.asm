section .data
    ht db 'Hello There! :D', 0xA
    htlen equ $-q

section .text
    global _start

_start:
    mov rsi, ht
    mov rdx, htlen
    call print

    call end

print:
    mov rax, 1
    mov rdi, 1
    syscall

end:
    mov rax, 60
    mov rdi, 0
    syscall
    