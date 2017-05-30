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

## Display

Display current assembly in top window

	> layout asm
	> layout split
	> layout regs
	> layout src
	> layout next
	> layout previous

Change window focus

	> focus src
	> focus asm
	> focus regs
	> focus cmd
	> focus next
	> focus prev

Refresh windows

	> refresh

Update source windows and current execution point

	> update

Change window height

	> winheight name +count
	> winheight name -count

Change tab depth for windows

	> tabset nchars

Enable TUI mode

	> tui enable

Exit TUI mode

	> tui disable
	 
## Functions

Define custom functions. For example:

	> define fn		//define a function named fn
	> si			//single step
	> x/20xw $esp		//display top 20 words on the stack
	> x/xw $ebp+8		//display return pointer (ebp+8)

## Inspect values

### Strings

Inspect a string:

	> x/s str_ptr
	> print str_ptr

Get the address of a string:

	> x/xw &str_ptr
