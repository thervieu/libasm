/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: thervieu <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/02/08 21:29:21 by thervieu          #+#    #+#             */
/*   Updated: 2020/02/08 21:29:23 by thervieu         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>

// Function prototypes

int		ft_strlen(char const *str);
int		ft_strcmp(char const *s1, char const *s2);
char	*ft_strcpy(char *dst, char const *src);
ssize_t	ft_write(int fd, void const *buf, size_t nbyte);
ssize_t	ft_read(int fd, void *buf, size_t nbyte);
char	*ft_strdup(char const *s1);

// Useful macros

# define STRLEN(tmp)		printf("'%s' -> True = %d && Me = %d\n", tmp, (int)strlen(tmp), ft_strlen(tmp));
# define STRCMP(a, b)		printf("'%s' && '%s' -> True = %d && Me = %d\n", a, b, strcmp(a, b), ft_strcmp(a, b));
# define WRITE(str, nb)		printf(" && %ld <-'%s' && %ld\n", ft_write(STDOUT_FILENO, str, nb), str, nb);
# define READ(buffer, x)	r = ft_read(STDIN_FILENO, buffer, x); printf("%d -> '%s' && %ld\n", x,  buffer, r);
# define DUP(str)			tmp = ft_strdup(str); printf("'%s' -> '%s'\n", str, tmp); free(tmp); tmp = NULL;

// Main

int		main(void)
{
	int		i;
	long	r;
	char	buffer[100];
	char	*tmp;
	char	*tmp2;

	r = 0;
	i = 0;
	while (i < 100)
		buffer[i++] = 0;

	printf("____________________Begin____________________\n\n");
	printf("_____strlen_____\n\n");
	STRLEN("")
	STRLEN("toto")
	STRLEN("totototo")
	STRLEN("0123456789abcdef")
	STRLEN("42")
	STRLEN("1")
	printf("\n");

	printf("\n_____strcmp_____\n\n");
	STRCMP("", "")
	STRCMP("toto", "toto")
	STRCMP("", "toto")
	STRCMP("toto", "")
	STRCMP("toto", "totobar")
	printf("'%s':'%s' -> Me = %d\n", "TOTO", NULL, ft_strcmp("TOTO", NULL));
	printf("'%s':'%s' -> Me = %d\n", NULL, "TOTO", ft_strcmp(NULL, "TOTO"));
	printf("'%s':'%s' -> Me = %d\n", NULL, NULL, ft_strcmp(NULL, NULL));

	printf("\n_____strcpy_____\n\n");
	printf("'toto' -> '%s'\n", ft_strcpy(buffer, "toto"));
	printf(""" -> %s\n", ft_strcpy(buffer, ""));
	printf("'long message' -> %s\n", ft_strcpy(buffer, "long message"));
	printf("NULL -> %s\n", ft_strcpy(buffer, NULL));
	printf("\n");

	printf("\n_____write_____\n\n");
	WRITE("toto", 4L)
	WRITE("totototo", 4L)
	WRITE("totototo", 8L)
	WRITE("toto", 2L)
	printf("\n");

	printf("\n_____read (Makefile)_____\n\n");
	READ(buffer, 50)
	i = 0;
	while (i < 100)
		buffer[i++] = 0;
	READ(buffer, 25)
	i = 0;
	while (i < 100)
		buffer[i++] = 0;
	READ(buffer, 4)
	i = 0;
	while (i < 100)
		buffer[i++] = 0;
	READ(buffer, 26)
	i = 0;
	while (i < 100)
		buffer[i++] = 0;
	READ(buffer, 14)
	i = 0;
	while (i < 100)
		buffer[i++] = 0;
	READ(buffer, 0)
	printf("\n");

	printf("\n_____ft_strdup_____\n\n");
	tmp2 = ft_strdup("toto");
	DUP(tmp2)
	free(tmp2);
	DUP("totobar")
	DUP("long message")
	DUP("")
	DUP(NULL)
	printf("\n\n____________________all done :)____________________\n\n");
	return (0);
}
