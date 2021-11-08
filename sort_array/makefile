C = gcc
FS = fasmg.sh
OBJ_D = obj
BIN_D = bin
SRC_D = src

all: main

main:
	$(FS) func.asm
	gcc -g main.c func func.h


.PHONY : clean
clean:
	rm -rf bin/ obj/
	rm func
	rm func.h.gch
