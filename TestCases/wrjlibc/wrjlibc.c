#undef HAS_LIBC

#ifdef HAS_LIBC
// If you are running on spike, then use this
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

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

int _wrjlibc__StringEqual(char* a, char* b) {
	return !strcmp(a, b);
}

#else
// if you are running on rucore, use this

int syscall_write(int fd, const char* buf, int size) {
	int rv;
	__asm__ __volatile__ (
			"li a7, %1\n\t"
			"mv a0, %2\n\t"
			"mv a1, %3\n\t"
			"mv a2, %4\n\t"
			"ecall\n\t"
			"mv %0, a0\n\t"
			: "=r" (rv)
			: "i" (64), // write sysno
			  "r" (fd),
			  "r" (buf),
			  "r" (size)
			: "a0", "a1", "a2", "a7"
	);
	return rv;
}

int syscall_exit(int err) {
	int rv;
	__asm__ __volatile__ (
			"li a7, %1\n\t"
			"mv a0, %2\n\t"
			"ecall\n\t"
			"mv %0, a0\n\t"
			: "=r" (rv)
			: "i" (93), // exit sysno
			  "r" (err)
			: "a0", "a7"
	);
	return rv;
}

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
// what the fxxk? If I put this on stack,
//  it crashes with my own syscall_write
// if it's a global variable, everything's fine?
char buf[11]; // 11 chars ought to be enough
void _wrjlibc__PrintInt(int v) {
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

int _wrjlibc__StringEqual(char* a, char* b) {
	for (int i = 0; a[i] || b[i]; i++)
		if (a[i] != b[i]) return 0;
	return 1;
}

#endif // HAS_LIBC
