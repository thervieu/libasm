# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_strdup.s                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: user42 <user42@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/07 19:19:22 by thervieu          #+#    #+#              #
#    Updated: 2020/12/21 22:12:36 by user42           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

    section .text
    extern  ft_strlen
    extern  ft_strcpy
    extern  malloc
    extern  __errno_location
    global  ft_strdup

ft_strdup:
    push    rdi             ; save rdi_init
    call    ft_strlen       ;
    inc     rax             ; + 1 for \0
    mov     rdi, rax        ; put len in rdi for malloc
    call    malloc wrt ..plt
    cmp     rax, 0          ; check error
    je      _error          ; if error, handle error
    pop     rdi             ;
    mov     rsi, rdi
    mov     rdi, rax
    call    ft_strcpy
    ret

_error:
    neg     rax
    mov     rdi, rax
    call    __errno_location wrt ..plt
    mov     [rax], rdi
    mov     rax, 0
    ret
