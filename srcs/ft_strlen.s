section .text
	global  ft_strlen

ft_strlen:          ; rax = return value ; rdi = str
	push    rbx             ; save any registers
	push    rcx             ; rcx is our iterator
	mov     rbx, rdi        ; rbx = rdi
	xor     al, al          ; al = 0;
	mov     rcx, 0xffffffff ; rcx = max bytes since we use it to decrement
	repne   scasb           ; while ([rdi] != al) {rdi++ && rcx--}
	sub     rdi, rbx        ; get length + 1
	dec     rdi             ; decrement to get length
	pop     rcx             ; restore registers
	pop     rbx             ; restore registers
	mov     rax, rdi        ; put length in return register
	ret                     ; return (rax)
