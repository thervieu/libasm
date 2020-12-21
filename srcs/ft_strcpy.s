section .text
	global	ft_strcpy

ft_strcpy:	; rsi = src rdi = dest
	xor		rcx, rcx	; rcx = 0
	cmp 	rsi, 0		; if (rsi[0] == '\0')
	jz 		ret			; return
	jmp 	copy		; to not inc rcx

increment:
	inc 	rcx		; rcx++;

copy:								; need dl as a tmp to swap because you cant move bytes [] directly
	mov 	dl, BYTE[rsi + rcx]		; tmp = rsi[rcx]
	mov 	BYTE[rdi + rcx], dl		; rdi[rcx] = tmp
	cmp 	dl, 0					; dl == 0 ?
	jnz 	increment				; if it is not the end byte '\0', increment rcx
	jmp 	ret						; else go to return

ret:
	mov 	rax, rdi	; return value set at first byte of dst
	ret					; return