ant clean
ant
java -jar result/decaf.jar -l 4 myT.decaf > myT.s
echo "complier ok"
riscv32-unknown-elf-gcc -c myT.s
riscv32-unknown-elf-gcc myT.o -o myT
