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
	call    __errno_location wrt ..plt
	mov     rax, 0			; rax = 0
	ret						; return (rax)
