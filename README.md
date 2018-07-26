# Decaf RISCV
[![Build Status](https://travis-ci.org/riscv-and-rust-and-decaf/decaf-riscv-compiler.svg?branch=master)](https://travis-ci.org/riscv-and-rust-and-decaf/decaf-riscv-compiler)

Decaf 语言在 riscv 指令集上的移植.

# 环境需求
运行需要 rv32 工具链, 尤其是 `riscv32-unknown-elf-gcc`,
以及模拟器 `spike` 和一个运行环境 proxykernel.

工具链仓库在 [github 上](https://github.com/riscv/riscv-tools),
可以手动编译, 或者咨询组织成员请求 prebuilt 版本.

为了编译 Decaf 编译器, 需要 `ant` 工具.

# 运行测试
需要先配置测试文件 `TestCases/rv/testall`, 修改
```
SPIKE=/home/hob/Programs/riscv/bin/spike
PROXYKERNEL=/home/hob/Programs/riscv/riscv32-unknown-elf/bin/pk
```
为你的 `spike` 和 `pk` 的位置.

~~~ bash
$ ant
$ cd TestCases/rv
$ ./testall
~~~

