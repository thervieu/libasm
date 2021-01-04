/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: user42 <user42@student.42.fr>              +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/08/09 12:13:54 by gozsertt          #+#    #+#             */
/*   Updated: 2021/01/04 11:45:33 by user42           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm.h"

#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/uio.h>

#define RESET "\x1b[0m"
#define GREEN "\x1b[32m"
#define RED "\x1b[31m"

static void		strlen_test(char *str)
{
	int ret1 = ft_strlen(str);
	int ret2 = strlen(str);
	
	printf("str = |%s|\n", str);
	printf("ret1 = %d, ret2 = %d\n", ret1, ret2);
	
	if (ret1 != ret2)
		printf(RED"ERROR\n\n"RESET);
	else
		printf(GREEN"SUCCESS\n\n"RESET);
}

static void		strcpy_test(char *str)
{
	char buf1[10000] = {0};
	char buf2[10000] = {0};
	
	char *ret1 = ft_strcpy(buf1, str);
	char *ret2 = strcpy(buf2, str);
	
	printf("buf1 = |%s|\nbuf2 = |%s|\n", buf1, buf2);
	
	if (strcmp(buf1, buf2) != 0)
		printf(RED"ERROR\n\n"RESET);
	else
		printf(GREEN"SUCCESS\n\n"RESET);
}

static void		strcmp_test(char *str1, char *str2)
{
	int ret1 = ft_strcmp(str1, str2); 
	int ret2 = strcmp(str1, str2);
	
	printf("comparing |%s| and |%s|\n", str1, str2);
	
	printf("ret1 = %d, ret2 = %d\n", ret1, ret2);
	
	if ((ret1 < 0 && ret2 < 0) || (!ret1 && !ret2 ) || (ret1 > 0 && ret2 > 0))
		printf(GREEN"SUCCESS\n\n"RESET);
	else
		printf(RED"ERROR\n\n"RESET);
}

static void		write_test(int fd, char *str)
{
	char buf1[4096] = {0};
	char buf2[4096] = {0};
	int ret1;
	int ret2;
	
	printf("testing fd = %d, str = |%s|\n", fd, str);

	if (fd > 2)
	{
		int fd1 = open("writefile_1", O_CREAT | O_TRUNC | O_RDWR, 0777);
		int fd2 = open("writefile_2", O_CREAT | O_TRUNC | O_RDWR, 0777);
		ret1 = ft_write(fd1, str, strlen(str));
		read(fd1, buf1, strlen(str) + 1);
		ret2 = write(fd2, str, strlen(str));
		read(fd2, buf2, strlen(str) + 1);
	}
	else if (fd < 0)
	{
		errno = 0;
		ret1 = ft_write(fd, str, strlen(str) + 1);
		printf("errno = %d, strerror = |%s|\n", errno, strerror(errno));
		errno = 0;
		ret2 = write(fd, str, strlen(str) + 1);
		printf("errno = %d, strerror = |%s|\n", errno, strerror(errno));
	}
	else
	{
		ret1 = ft_write(fd, str, strlen(str) + 1);
		ret2 = write(fd, str, strlen(str) + 1);
	}

	printf("ret1 = %d, ret2 = %d\n", ret1, ret2);

	if (ret1 == ret2)
	{
		printf(GREEN"ret value OK, "RESET);
		if (strcmp(buf1, buf2) == 0)
			printf(GREEN"contents OK, SUCCESS\n\n"RESET);
		else
			printf(RED"contents not the same, ERROR\n\n"RESET);
	}
	else
		printf(RED"Ret values not OK, ERROR\n\n"RESET);
}

static void		read_test_openfd(char *str)
{
	char buf1[4096] = {0};
	char buf2[4096] = {0};
	int fd = open("readfile", O_CREAT | O_RDWR | O_TRUNC, 0777);
	
	write(fd, str, strlen(str));
	
	printf("testing read on fd = %d, contents = |%s|\n", fd, str);
	
	int ret1, ret2;
	
	lseek(fd, 0, SEEK_SET);
	errno = 0;
	ret2 = read(fd, buf2, 1000);
	
	printf("ret2 = %d, bufd = |%s|, errno %d |%s|\n", ret2, buf2, errno, strerror(errno));
	
	lseek(fd, 0, SEEK_SET);
	errno = 0;
	ret1 = ft_read(fd, buf1, 1000);
	printf("ret1 = %d, buf1 = |%s|, errno %d |%s|\n", ret1, buf1, errno, strerror(errno));
	
	if (ret1 == ret2)
	{
		if (!(strcmp(buf1, buf2)))
			printf(GREEN"SUCCESS\n\n"RESET);
		else
			printf(RED"buf1 != buf2, ERROR\n\n"RESET);
	}
	else
		printf(RED"ret1 != ret2, ERROR\n\n"RESET);
}

static void		read_test_badfd(void)
{
	char buf1[4096] = {0};
	char buf2[4096] = {0};
	int ret1;
	int ret2;
	
	printf("testing read on badfd\n");
	errno = 0;
	ret1 = ft_read(-1, buf1, 42);
	
	printf("ret1 = %d, buf1 = |%s|, errno = %d, strerror = |%s|\n",
			ret1, buf1, errno, strerror(errno));
	
	errno = 0;
	ret2 = read(-1, buf2, 42);
	printf("ret2 = %d, buf2 = |%s|, errno = %d, strerror = |%s|\n",
			ret2, buf2, errno, strerror(errno));
	
	if (ret1 == ret2)
	{
		if (!(strcmp(buf1, buf2)))
			printf(GREEN"SUCCESS\n\n"RESET);
		else
			printf(RED"buf1 != buf2, ERROR\n\n"RESET);
	}
	else
		printf(RED"ret1 != ret2, ERROR\n\n"RESET);
}

static void		strdup_test(char *str)
{
	char *str1, *str2;
	
	errno = 0;
	str1 = ft_strdup(str);
	
	printf("str1 = |%s|, errno = %d |%s|\n", str1, errno, strerror(errno));
	
	errno = 0;
	str2 = strdup(str);
	
	printf("str2 = |%s|, errno = %d |%s|\n", str2, errno, strerror(errno));
	
	if (!strcmp(str1, str2))
		printf(GREEN"SUCCESS\n\n"RESET);
	else
		printf(RED"ERROR\n\n"RESET);
	
	free(str1);
	free(str2);
}

static void		strdup_test_heap(char *str)
{
	char *str1, *str2;
	char *s = strdup(str);
	
	errno = 0;
	str1 = ft_strdup(s);
	
	printf("str1 = |%s|, errno = %d |%s|\n", str1, errno, strerror(errno));
	
	errno = 0;
	str2 = strdup(s);
	
	printf("str2 = |%s|, errno = %d |%s|\n", str2, errno, strerror(errno));
	
	if (!strcmp(str1, str2))
		printf(GREEN"SUCCESS\n\n"RESET);
	else
		printf(RED"ERROR\n\n"RESET);
	
	free(str1);
	free(str2);
	free(s);
}

int main()
{
	printf("\nSTRLEN TEST\n");

	strlen_test("");
	strlen_test("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore");
	strlen_test("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.");

	printf("\n\nSTRCPY TEST\n");
	
	strcpy_test("");
	strcpy_test("abcdef");
	strcpy_test("abcdefghijklmnopqrstuvwxyz :)");
	strcpy_test("Lorem ipsum dolor sit amet, consectetur adipiscing elit");
	strcpy_test("Lorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elit");


	printf("\n\nSTRCMP TEST\n");
	
	strcmp_test("", "");
	strcmp_test("", "hello");
	strcmp_test("wonderful world", "");
	strcmp_test("bonjour", "au revoir");
	strcmp_test("identiques", "identiques");
	strcmp_test("testtesttesttesttesttesttesttesttesttesttesttest", "testtesttesttesttesttesttesttesttesttesttesttest");

	printf("\n\nWRITE TEST\n");
	
	write_test(fileno(stdout), "stdout test test test");
	write_test(-1, "badfd test test test");
	write_test(42, "open file fd test test test");

	printf("\n\nREAD TEST\n");
	
	read_test_openfd("This goes to a fd test test test");
	read_test_badfd();

	printf("\n\nSTRDUP TEST\n");
	
	strdup_test("");
	strdup_test("hello");
	strdup_test("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.");

	strdup_test_heap("");
	strdup_test_heap("hello");
	strdup_test_heap("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.");

}
