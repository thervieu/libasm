section .text

	extern __errno_location
    global ft_read

ft_read:				; fd = rdi, buffer = rsi, bytes = rdx
	mov		rax, 0		; put read in rax
	syscall				; sytem call to rax (= read)
	cmp		rax, 0		; compare rax and 0
	jl 		_error		; if error jump to error jl = jump if lower
	ret					; else return

_error:
	call 	__errno_location	wrt ..plt
	mov 	rax, -1		; since there is an error we return -1
	ret					; return (-1)