# Decaf RISCV

本仓库内容为 Decaf 语言在 riscv 指令集上的移植.

# 环境需求
运行需要 rv32 工具链, 尤其是 `riscv32-unknown-elf-gcc`,
以及模拟器 `spike` 和一个运行环境 proxykernel.

工具链仓库在 [github 上](https://github.com/riscv/riscv-tools),
可以手动编译, 或者咨询组织成员请求 prebuilt 版本.

为了编译 Decaf 编译器, 需要 `ant` 工具.

# 运行测试
~~~ bash
$ ant
$ cd TestCases/wrjlibc
$ make
$ cd ../rv
$ ./testall
~~~

