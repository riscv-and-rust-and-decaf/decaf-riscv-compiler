all: wrjlibc.o

clean:
	rm *.o *.a

%.o: %.c
	riscv32-unknown-elf-gcc $^ -c -O2

.PHONY: all clean
