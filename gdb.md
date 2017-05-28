# gdb

GNU Debugger.

## Basic Usage

Debug a file:
	
	>  gdb program

Debug a process:
	
	 > gdb -p 1234

## Navigation

Display next 10 instructions:
	
	> x/10i
	 
## Inspect values

Inspect a string:

	> x/s str_ptr
	> print str_ptr

Get the address of a string:

	> x/xw &str_ptr
