# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_read.s                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: user42 <user42@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/07 19:29:20 by thervieu          #+#    #+#              #
#    Updated: 2020/10/03 17:48:49 by user42           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

	default rel
    global _ft_read
	extern ___error

	section .text

_ft_read:					; fd = rdi, buffer = rsi, bytes = rdx
		mov	rax, 0x2000003	; put write in rax
		syscall				; sytem call to rac (= read)
		jc _error			; if error jump to error
		ret					; else return

_error:
		mov rdx, rax		; rdx = rax
		push rdx			; save that value
		call ___error		; call errno
		pop rdx				; get errno back
		mov [rax], rdx		; put errno in int *
		mov rax, -1			; since there is an error we return -1
		ret					; return (-1)