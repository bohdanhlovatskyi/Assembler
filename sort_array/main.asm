
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

  section '__text' align 16

    entry start

start:
	; and	rsp, 0xFFFFFFFFFFFFFFF0
	sub	rsp, 0x10

    ; call func
    
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
     ; loads all the data needed to call debug print for 4 elms,
     ; basing on the calling conventions RDI, RSI, RDX, RCX, R8, R9
     lea rdi, [dbg_msg]
     mov esi, DWORD [data]
     mov edx, DWORD [data + 4]
     mov ecx, DWORD [data + 8]
     mov r8d, DWORD [data + 12]

     push rax ; stores the value of rax register
     xor rax, rax ; convention call
 	 call printf
     pop rax
     pop rbp
     ret

    section '__cstring' align 4
    dbg_msg: db '[arr]: %u %u %u %u',0Ah,0

segment '__DATA' readable writeable
  section '__data' align 16
    data dd 5, 4, 2, 8
    size dq 4