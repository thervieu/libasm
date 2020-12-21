section .text
    global  ft_strlen

ft_strlen:
    push    rbx             ; save any registers
    push    rcx             ; trash
    mov     rbx, rdi        ; rbx = rdi
    xor     al, al          ; al = 0;
    mov     rcx, 0xffffffff ; rcx = max bytes since we use it to decrement
    repne   scasb           ; while ([rdi] != al) {rdi++ && rcx--} (uses flag DF)
    sub     rdi, rbx        ; get length + 1 
    dec     rdi             ; decrement to get length
    mov     rax, rdi        ; put length in return register
    pop     rcx             ; restore registers
    pop     rbx             ; restore registers
    ret                     ; return (rax)
