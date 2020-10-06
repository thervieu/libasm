# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_strcmp.s                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: thervieu <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/11/21 17:11:45 by thervieu          #+#    #+#              #
#    Updated: 2019/11/21 17:11:47 by thervieu         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

	section .text
	global	ft_strcmp

ft_strcmp:
	push	rdx
	push	rcx
	xor 	rax, rax
	xor 	rdx, rdx

cmp_loop:
	mov		cl, byte [rsi + rdx]
	cmp		byte [rdi + rdx], cl
	jl		lower
	jg		greater
	or		cl, cl
	jz		end
	inc		rdx
	jmp		cmp_loop

lower:
	mov		rax, -1
	jmp end
	
greater:
	mov		rax, 1

end:
	pop 	rdx
	pop		rcx
	ret
