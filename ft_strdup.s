# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_strdup.s                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: thervieu <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/07 19:19:22 by thervieu          #+#    #+#              #
#    Updated: 2020/02/07 19:19:23 by thervieu         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

section .text
    extern _ft_strlen
    extern _ft_strcpy
    extern _malloc
    global _ft_strdup

_ft_strdup:
    push rdi            ; save rdi_init

    cmp rdi, 0          ; if !rdi
    je strdup_error     ; return
    call _ft_strlen     ; get_length
    inc rax             ; get \0

    mov rdi, rax        ; rdi = length
    call _malloc        ; malloc length
    cmp rax, 0          ; if pb during malloc
    je strdup_error     ; return

    pop rsi             ; rsi = rdi_init
    mov rdi, rax        ; rdi = length
    call _ft_strcpy     ; cpy rdi into rsi
    ret                 ; return

strdup_error:
    pop rdi             ; rdi = rdi_init
    ret                 ;return