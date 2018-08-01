all: wrjlibc.o

CFLAGS=-nostdlib -nodefaultlibs -nostartfiles

clean:
	rm *.o

wrjlibc.o: wrjlibc.c
	riscv32-unknown-elf-gcc $^ -c -O2 -DHAS_LIBC=$(HAS_LIBC) -DBAREMETAL=$(BAREMETAL) $(CFLAGS) -static

.PHONY: all clean
