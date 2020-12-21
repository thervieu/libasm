    section .text

    extern  __errno_location
    global  ft_write

ft_write:
    mov     rax, 1  ; write = 1
    syscall             ; call system rax = write
    cmp     rax, 0
    jl      _error            ; if error jump to error
    ret                 ; else return

_error:
    neg		rax			; set errcode to positive
	mov		rdi, rax		; store errcode in %rdi
	call	__errno_location wrt ..plt	; get errno location
	mov		[rax], rdi		; initialize errno with errcode
	mov		rax, -1			; return -1
	ret