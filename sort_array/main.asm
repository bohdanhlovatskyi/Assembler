
include 'cpu/x64.inc'
use64

MachO.Settings.ProcessorType equ CPU_TYPE_X86_64
MachO.Settings.BaseAddress = 0x1000000

include 'format/macho.inc'

interpreter '/usr/lib/dyld'
uses '/usr/lib/libSystem.B.dylib' (1.0.0, 1226.10.1)
import printf,'_printf'
import exit,'_exit'

uses './libfunc.so'
import func,'_func'

segment '__TEXT' readable executable

  section '__cstring' align 4
    msg: db '%u     ', 0
    newline: db 0Ah, 0

  section '__text' align 16

    entry start

start:
	; and	rsp, 0xFFFFFFFFFFFFFFF0
	sub	rsp, 0x10

    ; RDI, RSI, RDX, RCX, R8, R9. So,
	call print_arr

    mov rsi, 4
    lea rdi, [data]
    call func

    call print_arr

    add rsp, 0x10
	xor	rdi,rdi
	call	exit

  print_arr:
    push rbp
    mov rbp, rsp

    mov r13, 0 ; counter for size
    pl:
        lea rax, [size] ; loads address of size variable into the rax
        cmp r13, [rax]
        jnl end_of_loop
    
        lea rdi, [msg]
        lea rax, [data]
        mov rsi, [rax + 4 * r13] ; data[i]
        xor rax, rax
        call printf
    
        inc r13
        jmp pl

   end_of_loop:
    lea rdi, [newline]
    xor rax, rax
    call printf

    pop rbp
    ret

segment '__DATA' readable writeable
  section '__data' align 16
    data dd 5, 4, 2, 8
    size dq 4