#if HAS_LIBC
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
#include <stdarg.h>

#define MAX_ARGS            5
#define SYS_write 103
#define SYS_exit 1

static inline int
syscall(int num, ...) {
    va_list ap;
    va_start(ap, num);
    unsigned a[MAX_ARGS];
    int i, ret;
    for (i = 0; i < MAX_ARGS; i ++) {
        a[i] = va_arg(ap, unsigned);
    }
    va_end(ap);

    asm volatile (
        "lw a0, %1\n"
        "lw a1, %2\n"
        "lw a2, %3\n"
        "lw a3, %4\n"
        "lw a4, %5\n"
        "lw a5, %6\n"
        "ecall\n"
        "sw a0, %0"
        : "=m" (ret)
        : "m" (num),
          "m" (a[0]),
          "m" (a[1]),
          "m" (a[2]),
          "m" (a[3]),
          "m" (a[4])
        : "memory"
      );
    return ret;
}

int
sys_write(int fd, const void *base, unsigned len) {
    return syscall(SYS_write, fd, base, len);
}

int
sys_exit(int error_code) {
    return syscall(SYS_exit, error_code);
}

// guarantees no partial write unless error happened
void write_flushed(int fd, const char* v, int size) {
	sys_write(fd, v, size);
// Seems there's some bug with the return value of write?
//	int n_totwr = 0;
//	while (n_totwr < size) {
//		int n_wr = sys_write(fd, v + n_totwr, size - n_totwr);
//		if (n_wr < 0) {
//			// error?!
//		} else {
//			n_totwr += n_wr;
//		}
//	}
}

const char* num = "num";
// what the fxxk? If I put this on stack,
//  it crashes with my own sys_write
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
	sys_exit(1);
}

// 1M heap space
#define BUF_SIZE 1048576
char wrjbuf[BUF_SIZE];
int wrjbrk = 0;

// a stupid allocator
void* _wrjlibc__Alloc(unsigned size) {
	if (wrjbrk + size > BUF_SIZE) {
		return 0; // out of memory
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

extern void main();
void _start() {
	main();
	_wrjlibc__Halt();	// graceful exit
}

#endif // HAS_LIBC
