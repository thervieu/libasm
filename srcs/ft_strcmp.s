section .text
	global	ft_strcmp

ft_strcmp:	; rsi = str1  rdi = str2  rax = return_value
	xor 	rax, rax	; rax = 0
	xor 	rdx, rdx	; rdx = 0

cmp_loop:
	mov		cl, byte [rsi + rdx]	; cl = char *tmp used because we cant compare
	cmp		byte [rdi + rdx], cl	; two byte []
	jl		lower					; jl = jump if lower
	jg		greater					; jg = jump if greater
	cmp		cl, 0					; if rsi[rdx] == 0
	jz		end						; jz = jump if null
	inc		rdx						; inc = increment
	jmp		cmp_loop				; while loop

lower:
	mov		rax, -1					; rax = -1
	jmp end	
	
greater:
	mov		rax, 1					; rax = 1

end:
	ret
