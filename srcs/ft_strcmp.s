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
	global _ft_strcmp

_ft_strcmp:						; s1 = rdi, s2 = rsi
			xor	rcx, rcx		; i = 0
			xor	rdx, rdx		; cmp = 0
			cmp	rdi, 0			; !s1
			jz	check_null
			cmp	rsi, 0			; !s2
			jz check_null
			jmp	check

check_null:
			cmp	rdi, rsi
			jz	equal		; s1 == s2 (NULL)
			jg	sup			; s1 > s2
			jmp	inf			; s1 < s2

compare:
			mov	dl, BYTE [rsi + rcx]	; tmp = s2[i]
			cmp	BYTE [rdi + rcx], dl	; s1[i] == tmp
			jne	last

increment:
			inc		rcx

check:
			cmp	BYTE [rdi + rcx], 0		; !s1[i]
			je	last
			cmp	BYTE [rsi + rcx], 0		; !s2[i]
			je	last
			jmp	compare

last:
			mov	dl, BYTE [rdi + rcx]	; cmp = s1[i]
			sub	dl, BYTE [rsi + rcx]	; cmp -= s2[i]
			cmp	dl, 0					; cmp == 0
			jz	equal
			jl	inf

sup:
			mov	rax, 1
			ret

inf:
			mov	rax, -1
			ret

equal:
			mov	rax, 0
			ret