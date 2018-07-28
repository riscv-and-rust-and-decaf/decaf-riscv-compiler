all: wrjlibc.o

clean:
	rm *.o *.a

%.o: %.c
	riscv32-unknown-elf-gcc $^ -c -O2 -DHAS_LIBC=$(HAS_LIBC)

.PHONY: all clean
