section .text
	global	ft_strcmp

ft_strcmp:	; rsi = str1  rdi = str2  rax = return_value
	xor 	rax, rax	; rax = 0
	xor 	rdx, rdx	; rdx = 0

cmp_loop:
	mov 	cl, byte [rsi + rdx]
	mov		al, byte [rdi + rdx]	; cl = char *tmp used because we cant compare
	cmp		cl, al					; two byte []
	jl		diff					; jl = jump if lower
	jg		diff					; jg = jump if greater
	cmp		al, 0					; if rsi[rdx] == 0
	jz		end						; jz = jump if null
	inc		rdx						; inc = increment
	jmp		cmp_loop				; while loop

diff:
	movzx rcx, cl					; movzx is just mov from smaller registeries
	movzx rax, al					; to bigger and add zeroes where you must
	sub rax, rcx					; get diff

end:
	ret								; return diff
