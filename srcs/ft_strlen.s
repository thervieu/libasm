section .text
	global  ft_strlen

ft_strlen:          ; rax = return value ; rdi = str
	xor rax, rax	; i = 0

_loop:
	cmp BYTE [rdi + rax], 0	; if str[i] == '\0'
	je ret					; jump to the end
	inc rax					; i++
	jmp _loop				; while loop

ret:
	ret