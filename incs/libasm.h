#ifndef LIBASM_H
# define LIBASM_H

# include <unistd.h>
# include <errno.h>
# include <string.h>
# include <sys/types.h>
# include <sys/uio.h>
# include <unistd.h>
# include <stdlib.h>
# include <unistd.h>
# include <stdio.h>
# include <fcntl.h>

size_t		ft_strlen(char *s);
size_t		ft_write(int fd, const void *buf, size_t count);
int			ft_strcmp(const char *s1, const char *s2);
char		*ft_strcpy(char *dst, const char *src);
char		*ft_strdup(const char *s);
ssize_t		ft_read(int fildes, void *buf, size_t nbytes);

#endif