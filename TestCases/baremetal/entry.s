.globl _start
_start:
	nop
	nop
	li sp, 0x80400000
	j main
spin:
	j spin
