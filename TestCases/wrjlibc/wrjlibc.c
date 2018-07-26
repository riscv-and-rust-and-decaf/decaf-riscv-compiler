#undef HAS_LIBC

#ifdef HAS_LIBC
// If you are running on spike, then use this
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

void _wrjlibc__PrintInt(int v) {
	printf("%d", v);
}

void _wrjlibc__PrintString(char* v) {
	printf("%s", v);
}

void _wrjlibc__PrintBool(int v) {
	printf(v ? "true" : "false");
}

void _wrjlibc__Halt(void) {
	exit(1);
}

void* _wrjlibc__Alloc(unsigned size) {
	return malloc(size);
}


#else
// if you are running on rucore, use this
//	(but it's ok if this is used on spike)
#include <unistd.h>

#define syscall_write(...) write(__VA_ARGS__)
#define syscall_exit(...) _exit(__VA_ARGS__)

// guarantees no partial write unless error happened
void write_flushed(int fd, const char* v, int size) {
	int n_totwr = 0;
	while (n_totwr < size) {
		int n_wr = syscall_write(fd, v + n_totwr, size - n_totwr);
		if (n_wr < 0) {
			// error?!
		} else {
			n_totwr += n_wr;
		}
	}
}

const char* num = "num";
void _wrjlibc__PrintInt(int v) {
	char buf[11]; // 11 chars ought to be enough
	int len = 10;
	int neg = 0;
	if (v < 0) {
		neg = 1;
		v = -v;
	}
	do {
		buf[len--] = v % 10 + '0';
		v /= 10;
	} while (v > 0);
	if (neg)
		buf[len--] = '-';
	write_flushed(1, buf + len + 1, 10 - len);
}

void _wrjlibc__PrintString(char* v) {
	int len = 0;
	while (v[len] != 0) len++;
	write_flushed(1, v, len);
}

const char* truestr = "true";
const char* falsestr = "false";
void _wrjlibc__PrintBool(int v) {
	if (v) {
		write_flushed(1, truestr, 4);
	} else {
		write_flushed(1, falsestr, 5);
	}
}

void _wrjlibc__Halt(void) {
	syscall_exit(1);
}

// 1M heap space
#define BUF_SIZE 1048576
char wrjbuf[BUF_SIZE];
int wrjbrk = 0;

// a stupid allocator
void* _wrjlibc__Alloc(unsigned size) {
	if (wrjbrk + size > BUF_SIZE) {
		return NULL; // out of memory
	} else {
		void* rv = wrjbuf + wrjbrk;
		wrjbrk += size;
		return rv;
	}
}

#endif // HAS_LIBC
