
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

  section '__TEXT':'__text'

  entry start

  start:
    and	rsp,0xFFFFFFFFFFFFFFF0
    sub rsp, 0x10

    mov DWORD [rsp + 0x8], 0x3
    mov DWORD [rsp + 0x4], 0x2
    mov DWORD [rsp], 0x1 
    
    mov rdi, rsp
    mov rsi, 0x3
    call _func

    add rsp, 0x10
    xor	rdi, rdi
	call exit

  ; sorts array of uint32_t of size_t nums
  _func:
    mov rbp,rsp
    mov rcx, rsi    ; this register will be checked by the loop

    ; R8 - j, R9 - i, R10 - key, R11 - A[i], RDI - beginning of array, RSI - size of array 
    mov RAX, 1
    mov R8, 1  
    cmp R8, RSI
    jl Looping1
    je EndOfLoop1
    Looping1:
    lea R10,[R8] 
    mov R9, R8
    dec R9 
    cmp R9, 0
    jl EndOfLoop2
    mov R11, [RDI+8*R9]

    cmp R11, R10
    jle EndOfLoop2
    jg Looping2
    Looping2:
    mov [RDI + 8*R9 + 8], R11 
    dec R9
    cmp R9, 0
    jl EndOfLoop2
    mov R11, [RDI + 8*R9]
    cmp R11, R10
    jle EndOfLoop2
    jg Looping2
    jmp EndOfLoop2
    EndOfLoop2:
    mov [RDI + 8*R9 + 8], R10
    inc R8
    cmp R8, RSI
    jl Looping1
    je EndOfLoop1
    EndOfLoop1:
    mov RAX, 0
    ret

  section '__DATA':'__data'

	msg db 'Current elm: %d',0Ah, 0

    ; ------ vars definition ----------------------------
    arr_ptr dq 0
    size dq 0
