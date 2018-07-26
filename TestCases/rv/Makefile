ASMS := $(patsubst %.decaf,%.s,$(wildcard *.decaf))
EXES := $(patsubst %.decaf,%,$(wildcard *.decaf))
DECAF_JAR := ../../result/decaf.jar
WRJLIBC_DIR := ../wrjlibc
WRJLIBC_OBJ := $(WRJLIBC_DIR)/wrjlibc.o

all: asm

asm: $(ASMS)

exe: $(EXES)

clean:
	rm $(ASMS) $(EXES)

%.s: %.decaf $(DECAF_JAR)
	java -jar $(DECAF_JAR) -l 4 $< > $@

%: %.s $(WRJLIBC_OBJ)
	riscv32-unknown-elf-gcc $(WRJLIBC_OBJ) $< -o $@

.PHONY: all asm clean
