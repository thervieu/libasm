# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: user42 <user42@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/07 19:29:40 by thervieu          #+#    #+#              #
#    Updated: 2020/10/03 18:42:01 by user42           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME		=	libasm.a

NA			=	nasm

NA_FLAGS	=	-f macho64

FLAGS 		=	-Wall -Werror -Wextra

TEST		=	test

SRC_DIR		= 	srcs/

SRCS		=	ft_strlen.s \
				ft_strcmp.s \
				ft_strcpy.s \
				ft_write.s \
				ft_read.s \
				ft_strdup.s

OBJS		=	$(addprefix $(SRC_DIR), $(SRCS:.s=.o))

TEST		=	test

%.o: %.s
		$(NA) $(NA_FLAGS) -o $@ $<

all: $(NAME)

$(NAME): $(OBJS)
				ar rcs $(NAME) $(OBJS)

test:	$(NAME)
		gcc $(FLAGS) main.c $(NAME) -o test
		./$(TEST) < Makefile

clean:
	@echo "Remove .o  ..."
	@/bin/rm -f $(OBJS) 

fclean: clean
	@echo "Remove libasm ..."
	@/bin/rm -f $(NAME) $(TEST)

re: fclean all
