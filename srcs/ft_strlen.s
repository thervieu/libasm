# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ft_strlen.s                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: user42 <user42@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/07 18:40:26 by thervieu          #+#    #+#              #
#    Updated: 2020/10/03 17:27:19 by user42           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

section .text
    global _ft_strlen

_ft_strlen:
    push rbx            ; save register
    push rcx            ; save register
    mov rbx, rdi        ; rbx = memory of the first letter
    xor al, al          ; al = 0;
    mov rcx, 0xffffffff ; rcx = max bytes since we decrement it in next line
    repne scasb         ; while ([rdi] != al) {rdi++ && ecx--} ((uses flag DF))
    sub rdi, rbx        ; get length + 1 
    dec rdi             ; decrement to get length because of the way negative
                        ; bits are handled (-256, 0, 255 as an exemple for 8 bits)
    mov rax, rdi        ; put length in return register
    pop rbx             ; restore register
    pop rcx             ; restore register
    ret                 ; return (rax)
