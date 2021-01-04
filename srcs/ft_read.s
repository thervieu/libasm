section .text

	extern	__errno_location
    global	ft_read

ft_read:				; fd = rdi, buffer = rsi, bytes = rdx
	mov		rax, 0		; put read in rax
	syscall				; sytem call to rax (= read)
	cmp		rax, 0		; compare rax and 0
	jl 		_error		; if error jump to error jl = jump if lower
	ret					; else return

_error:
    neg rax
    mov rdi, rax		; put positive error_value in rdi for ernno call
	call	__errno_location wrt ..plt
    mov [rax], rdi		; put return_value of errno in pointer on rax to get error_msg
	mov		rax, -1		; return -1
	ret