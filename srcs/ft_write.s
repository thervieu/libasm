    default rel
    global  _ft_write
    extern  ___error

    section .text

_ft_write:
    mov rax, 0x2000004  ; write
    syscall             ; call system rax = write
    jc _error            ; if error jump to error
    ret                 ; else return

_error:
    mov rdx, rax        ; save errorvalue
    push rdx            ; push err
    call ___error       ; call errno
    pop rdx
    mov [rax], rdx
    mov rax, -1
    ret