# Build compiler: 		make compiler
# Compile to bin:		make myT
# Compile to asm:		make myT.s
# Run program:			make run prog=myT
# Run and dump: 		make run-dump prog=myT

CC := riscv64-unknown-elf-gcc
COMPILER := result/decaf.jar
prog := 

run: $(prog)
	spike pk $(prog)

run-dump: $(prog)
	spike -l pk $(prog) 2> dump

%: %.s
	$(CC) $< -o $@

%.s: %.decaf $(COMPILER)
	java -jar $(COMPILER) -l 4 $< > $@

compiler: $(COMPILER)

$(COMPILER):
	ant

clean:
	ant clean

.PHONY: all clean run compiler