# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_write.s                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: thervieu <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/07 19:29:08 by thervieu          #+#    #+#              #
#    Updated: 2020/02/07 19:29:10 by thervieu         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

section .text
    global _ft_write

_ft_write:
    mov rax, 0x2000004  ; write
    syscall
    ret