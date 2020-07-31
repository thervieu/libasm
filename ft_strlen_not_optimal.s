# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_strlen.s                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: thervieu <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/10/17 20:08:18 by thervieu          #+#    #+#              #
#    Updated: 2019/10/17 20:15:39 by thervieu         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

section .text
	global _ft_strlen

_ft_strlen:
	push rcx			; store rcx (counter)
	xor rcx, rcx		; rcx = 0
	
strlen_next:
	cmp [rdi], byte 0	; (rdi == '\0') ?
	je null				; if yes, go to null
	inc rcx				; increment counter
	inc rdi				; next stored letter
	jmp strlen_next		; loop until end

null:
	mov rax, rcx
	pop rcx				; restore rcx
	ret 				; end function