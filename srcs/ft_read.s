# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_read.s                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: user42 <user42@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/07 19:29:20 by thervieu          #+#    #+#              #
#    Updated: 2020/10/06 22:40:59 by user42           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

	section .text

	extern __errno_location
    global ft_read

ft_read:					; fd = rdi, buffer = rsi, bytes = rdx
	mov		rax, 0	; put write in rax
	syscall				; sytem call to rac (= read)
	cmp		rax, 0
	jl 		_error			; if error jump to error
	ret					; else return

_error:
	mov 	rdx, rax		; rdx = rax
	push 	rdx			; save that value
	call 	__errno_location	wrt ..plt	; call errno
	pop 	rdx				; get errno back
	mov 	[rax], rdx		; put errno in int *
	mov 	rax, -1			; since there is an error we return -1
	ret					; return (-1)