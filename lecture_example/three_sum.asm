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
    sub rsp, 0x12

    mov DWORD [rsp + 0x8], 0x3
    mov DWORD [rsp + 0x4], 0x2
    mov DWORD [rsp], 0x1 

    call three_sum

    mov rsi, rax
    lea	rdi,[msg]
    xor rax, rax
	call printf

	xor	rdi, rdi
	call exit

  three_sum: ; func that adds three nums and returns the result
    ; stack preparation
    push rbp
    mov rbp,rsp

    ; memory allocation for local variables
    ; sub rsp, 0x10

    mov eax, DWORD [rbp + 0xc]
    mov edx, DWORD [rbp + 0x8]
    add eax, edx
    add eax, DWORD [rbp + 0x10]
    
    ; saves the calculations from eax register
    ; into local variable assigned at this function's stack
    ; mov DWORD [rbp - 0x4], eax

    ; moves the local variable into eax that will be
    ; checked for function's return value
    ; mov eax, DWORD [rbp - 0x4]

    pop rbp
    ret

  section '__cstring' align 4

	msg db 'Result %d',0Ah,0

