section .text
	extern  ft_strlen
	extern  ft_strcpy
	extern  malloc
	extern  __errno_location
	global  ft_strdup

ft_strdup:
	push    rdi             ; save rdi
	call    ft_strlen       ; length in rax
	inc     rax             ; + 1 for \0
	mov     rdi, rax		; put length in rdi (used for malloc)
	call    malloc wrt ..plt	; rax contains the malloced address
	cmp     rax, 0          ; check error
	je      _error          ; if error, handle error
	pop     rdi             ; get rdi
	mov     rsi, rdi		; put rdi in rsi for strcopy call
	mov     rdi, rax		; rax contains malloc space 
	call    ft_strcpy
	ret

_error:
    neg rax
    mov rdi, rax		; put positive error_value in rdi for ernno call
	call	__errno_location wrt ..plt
    mov [rax], rdi		; put return_value of errno in pointer on rax to get error_msg
	mov		rax, -1		; return -1
	ret