section .text

    extern  __errno_location
    global  ft_write

ft_write:
    mov     rax, 1      ; write = 1
    syscall             ; call system rax = write
    cmp     rax, 0
    jl      _error      ; if (rax < 0) jump to error
    ret                 ; else return

_error:
    neg rax
    mov rdi, rax		; put positive error_value in rdi for ernno call
	call	__errno_location wrt ..plt
    mov [rax], rdi		; put return_value of errno in pointer on rax to get error_msg
	mov		rax, -1		; return -1
	ret