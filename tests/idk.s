section .data
    gt db 'Goodbye There! D:', 0xA
    gtlen equ $-gt

section .text
    global _start

_start:
    mov rsi, gt
    mov rdx, gtlen
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
    