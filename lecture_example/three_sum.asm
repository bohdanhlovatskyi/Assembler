include 'cpu/x64.inc'
use64

MachO.Settings.ProcessorType equ CPU_TYPE_X86_64
MachO.Settings.BaseAddress = 0x1000000

include 'format/macho.inc'

interpreter '/usr/lib/dyld'
uses '/usr/lib/libSystem.B.dylib' (1.0.0, 1226.10.1)
import printf,'_printf'
import exit,'_exit'

  section '__text' executable

  extrn three_sum
  
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

    ; numbers of xmm registers used
    xor rax, rax
	  call printf

    add rsp, 0x10

	  xor	rdi, rdi
	  call exit

  section '__cstring' align 4

	msg db 'Result %d',0Ah,0

