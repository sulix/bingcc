
#include <sys/stat.h>
#if __GLIBC_PREREQ(2,33)


/* glibc 2.33 changes how fstat() and stat() work enough to break bingcc
   for earlier versions.

   To work around this, we implement the new functions ourselves as
   wrappers around the old internal __xstat functions.

   See:
    - https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=8ed005daf0ab03e142500324a34087ce179ae78e
*/

#ifndef _STAT_VER
#if defined (__aarch64__)
#define _STAT_VER 0
#elif defined (__x86_64__)
#define _STAT_VER 1
#else
#define _STAT_VER 3
#endif
#endif

#ifndef _MKNOD_VER
#define _MKNOD_VER 1
#endif

extern int __lxstat(int ver, const char *filename, struct stat *stat);
int lstat(const char *filename, struct stat *stat)
{
	return __lxstat(_STAT_VER, filename, stat);
}

extern int __xstat(int ver, const char *filename, struct stat *stat);
int stat(const char *filename, struct stat *stat)
{
	return __xstat(_STAT_VER, filename, stat);
}

extern int __fxstat(int ver, int fd, struct stat *stat);
int fstat(int fd, struct stat *stat)
{
	return __fxstat(_STAT_VER, fd, stat);
}

extern int __fxstatat(int ver, int dirfd, const char *path, struct stat *stat, int flags);
int fstatat(int dirfd, const char *path, struct stat *stat, int flags)
{
	return __fxstatat(_STAT_VER, dirfd, path, stat, flags);
}

extern int __lxstat64(int ver, const char *filename, struct stat64 *stat);
int lstat64(const char *filename, struct stat64 *stat)
{
	return __lxstat64(_STAT_VER, filename, stat);
}

extern int __xstat64(int ver, const char *filename, struct stat64 *stat);
int stat64(const char *filename, struct stat64 *stat)
{
	return __xstat64(_STAT_VER, filename, stat);
}

extern int __fxstat64(int ver, int fd, struct stat64 *stat);
int fstat64(int fd, struct stat64 *stat)
{
	return __fxstat64(_STAT_VER, fd, stat);
}

extern int __fxstatat64(int ver, int dirfd, const char *path, struct stat64 *stat, int flags);
int fstatat64(int dirfd, const char *path, struct stat64 *stat, int flags)
{
	 return __fxstatat64(_STAT_VER, dirfd, path, stat, flags);
}

extern int __xmknod(int ver, const char *path, __mode_t mode, __dev_t dev);
int mknod(const char *path, __mode_t mode, __dev_t dev)
{
	return __xmknod(_MKNOD_VER, path, mode, dev);
}

extern int __xmknodat(int ver, int dirfd, const char *path, __mode_t mode, __dev_t dev);
int mknodat(int dirfd, const char *path, __mode_t mode, __dev_t dev)
{
	return __xmknodat(_MKNOD_VER, dirfd, path, mode, dev);
}

#endif

