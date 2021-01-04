# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: user42 <user42@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/07 19:29:40 by thervieu          #+#    #+#              #
#    Updated: 2021/01/04 11:45:15 by user42           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME		=	libasm.a

NA			=	nasm

NA_FLAGS	=	-f elf64

CC			=	clang

CC_FLAGS	=	-Wall -Werror -Wextra \
				-L. -lasm

HEADER		= ./incs

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

all:		 $(NAME)

$(NAME):	$(OBJS)
				ar rcs $(NAME) $(OBJS)

test:		$(NAME)
			gcc -I $(HEADER) ./main.c libasm.a -o $@

run: test
	@./test

clean:
	@echo "Remove .o  ..."
	@/bin/rm -f $(OBJS) 

fclean: clean
	@echo "Remove test_files ..."
	@echo "Remove test ..."
	@echo "Remove libasm.a ..."
	@/bin/rm -f $(NAME) $(TEST) readfile writefile_1 writefile_2

re: fclean all
