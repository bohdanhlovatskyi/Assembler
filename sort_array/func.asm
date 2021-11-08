include 'cpu/x64.inc'
use64

MachO.Settings.ProcessorType equ CPU_TYPE_X86_64
MachO.Settings.BaseAddress = 0x1000000

include 'format/macho.inc'

interpreter '/usr/lib/dyld'
uses '/usr/lib/libSystem.B.dylib' (1.0.0, 1226.10.1)
import printf,'_printf'
import exit,'_exit'

segment '__TEXT' readable executable

  section '__text' align 16

  entry start

  ; function that sorts array of uint32_t, given its size_t
  start:
	  and	rsp, 0xFFFFFFFFFFFFFFF0
    sub rsp, 32
    
    lea eax, [data]
    mov DWORD [rsp + 20], eax ; stores data in the stack as local variable
    lea rax, [size]
    mov QWORD [rsp + 16], rax ; stores the value of arr size in the stack
    
    call sort_arr

    call print_arr

	  xor	rdi,rdi
	  call	exit

  sort_arr:
    mov rbp, rsp
        
    ret


  print_arr:
    ; loads all the data needed to call debug print for 4 elms,
    ; basing on the calling conventions RDI, RSI, RDX, RCX, R8, R9
    lea	rdi,   [msg]
    mov esi, DWORD [data]
    mov edx, DWORD [data + 4]
    mov ecx, DWORD [data + 8]
    mov r8d, DWORD [data + 12]

    push rax ; stores the value of rax register
    xor rax, rax ; convention call
	  call printf
    pop rax

    ret

section '__data' align 16

    data dd 4, 3, 2, 1
    size dq 4
    msg db 'Result %u %u %u %u',0Ah,0