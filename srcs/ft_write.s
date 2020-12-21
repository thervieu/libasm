section .text

    extern  __errno_location
    global  ft_write

ft_write:
    mov     rax, 1      ; write = 1
    syscall             ; call system rax = write
    cmp     rax, 0
    jl      _error      ; if error jump to error
    ret                 ; else return

_error:
	call	__errno_location wrt ..plt
	mov		rax, -1			; return -1
	ret