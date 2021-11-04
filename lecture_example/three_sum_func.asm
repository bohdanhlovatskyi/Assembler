include 'cpu/x64.inc'
use64

MachO.Settings.FileType equ MH_OBJECT
MachO.Settings.ProcessorType equ CPU_TYPE_X86_64
MachO.Settings.ProcessorSubtype equ CPU_SUBTYPE_X86_64_ALL

include 'format/macho.inc'

section '__TEXT':'__text'

  public _three_sum

  ; func that adds three nums and returns the result
  _three_sum:
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
    ; !!! note that by convention c-function will check return value
    ; in the rax register
    mov edx, [rsp + 0x4]

    add rsp, 0x10
    ret
