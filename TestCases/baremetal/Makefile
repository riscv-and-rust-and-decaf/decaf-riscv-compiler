ASMS := $(patsubst %.decaf,%.s,$(wildcard *.decaf))
EXES := $(patsubst %.decaf,%,$(wildcard *.decaf))
BINS := $(patsubst %.decaf,%.bin,$(wildcard *.decaf))
DECAF_JAR := ../../result/decaf.jar
WRJLIBC_DIR := ../wrjlibc
WRJLIBC_OBJ := $(WRJLIBC_DIR)/wrjlibc.o
CFLAGS=-nostartfiles -nostdlib -nodefaultlibs -no-pie -T linker.ld
CC=riscv32-unknown-elf-gcc
OBJCOPY=riscv32-unknown-elf-objcopy

all: $(BINS)
asm: $(ASMS)
exe: $(EXES)

$(ASMS): %.s: %.decaf $(DECAF_JAR)
	java -jar $(DECAF_JAR) -l 4 $< > $@

$(EXES): %: %.s $(WRJLIBC_OBJ)
	$(CC) $(CFLAGS) entry.s $(WRJLIBC_OBJ) $< -o $@ 

$(BINS): %.bin: %
	$(OBJCOPY) -O binary $^ $@

clean:
	rm $(ASMS) $(EXES) $(BINS)

.PHONY: all asm exe clean
