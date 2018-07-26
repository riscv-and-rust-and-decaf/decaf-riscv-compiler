#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

void _wrjlibc__PrintInt(int v) {
	printf("%d\n", v);
}

void _wrjlibc__PrintString(char* v) {
	puts(v);
}

void _wrjlibc__PrintBool(int v) {
	puts(v ? "true" : "false");
}

void _wrjlibc__Halt(void) {
	exit(1);
}

void* _wrjlibc__Alloc(unsigned size) {
	return malloc(size);
}
