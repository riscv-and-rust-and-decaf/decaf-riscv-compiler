ASMS := $(patsubst %.decaf,%.s,$(wildcard *.decaf))
EXES := $(patsubst %.decaf,%,$(wildcard *.decaf))
DECAF_JAR := ../../result/decaf.jar
WRJLIBC_DIR := ../wrjlibc
WRJLIBC_OBJ := $(WRJLIBC_DIR)/wrjlibc.o

all: exe

asm: $(ASMS)

exe: $(EXES)

clean:
	rm $(ASMS) $(EXES)

$(ASMS): %.s: %.decaf $(DECAF_JAR)
	java -jar $(DECAF_JAR) -l 4 $< > $@

$(EXES): %: %.s
	riscv32-unknown-elf-gcc $(WRJLIBC_OBJ) $< -o $@

$(WRJLIBC_OBJ):
	make -C $(WRJLIBC_DIR)

.PHONY: all asm clean
