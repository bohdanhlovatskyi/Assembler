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

  start:
    and	rsp,0xFFFFFFFFFFFFFFF0
    sub rsp, 0x10

    mov DWORD [rsp + 0x8], 0x3
    mov DWORD [rsp + 0x4], 0x2
    mov DWORD [rsp], 0x1 

    call three_sum

    mov rsi, rdx
    lea	rdi,[msg]
    xor rax, rax
	  call printf

	  xor	rdi, rdi
	  call exit

  ; func that adds three nums and returns the result
  three_sum:
    mov rbp,rsp

    ; memory allocation for local variables
    ; alligned for 16 as gcc requires 
    sub rsp, 0x10

    mov eax, DWORD [rbp + 0xc]
    mov edx, DWORD [rbp + 0x8]
    add eax, edx
    add eax, DWORD [rbp + 0x10]
    
    ; saves the calculations from eax register
    ; into local variable assigned at this function's stack
    mov DWORD [rsp + 0x4], eax
    
    ; saves the value of local variable into return register
    mov edx, [rsp + 0x4]

    add rsp, 0x10
    ret

  section '__cstring' align 4

	msg db 'Result %d',0Ah,0

