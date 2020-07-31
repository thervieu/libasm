# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: thervieu <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/07 19:29:40 by thervieu          #+#    #+#              #
#    Updated: 2020/02/08 21:26:53 by thervieu         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME		=	libasm.a

NA			=	nasm

NA_FLAGS	=	-f macho64

FLAGS 		=	-Wall -Werror -Wextra

TEST		=	test

SRCS		=	ft_strlen.s \
				ft_strcmp.s \
				ft_strcpy.s \
				ft_write.s \
				ft_read.s \
				ft_strdup.s

OBJS		=	$(SRCS:.s=.o)

TEST		=	test

%.o: %.s
		$(NA) $(NA_FLAGS) $<

all: $(NAME)

$(NAME): $(OBJS)
				ar rcs $(NAME) $(OBJS)

test:	$(NAME)
		gcc $(FLAGS) $(NAME) -o $(TEST) main.c
# could use options -L. -lasm instead of $(NAME)
		./$(TEST) < Makefile

clean:
	@echo "Remove .o  ..."
	@/bin/rm -f $(OBJS) 

fclean: clean
	@echo "Remove libasm ..."
	@/bin/rm -f $(NAME) $(TEST)

re: fclean all

