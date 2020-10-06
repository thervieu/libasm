	section .text
	global	ft_strcpy

ft_strcpy:
	xor		rcx, rcx	; rcx = 0 (int i = 0)
	xor 	rdx, rdx	; tmp = 0 (char tmp = 0)
	cmp 	rsi, 0		; if (rsi[0] == '\0')
	jz 		ret			; return
	jmp 	copy		; to not inc rcx (stupid mistake)

increment:
	inc 	rcx		; rcx++;

copy:								; need dl as a tmp to swap
	mov 	dl, BYTE[rsi + rcx]		; tmp = rsi[rcx]
	mov 	BYTE[rdi + rcx], dl		; rdi[rcx] = tmp
	cmp 	dl, 0					; if (tmp != '\0')
	jnz 	increment				; go increment rcx
	jmp 	ret						; else go to return

ret:
	mov 	rax, rdi	; return value set at first byte of dst
	ret					; return