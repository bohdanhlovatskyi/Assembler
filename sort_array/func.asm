
include 'cpu/x64.inc'
use64

MachO.Settings.FileType equ MH_OBJECT
MachO.Settings.ProcessorType equ CPU_TYPE_X86_64
MachO.Settings.ProcessorSubtype equ CPU_SUBTYPE_X86_64_ALL
include 'format/macho.inc'

section '__TEXT':'__text'

  public _func

  ; func that adds three nums and returns the result
  _func:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    ; as function can easily change each of the following registers:
    ; RAX, RCX, RDX, RSI, RDI, R8-R11 we will use them for the vars.
    ; Also note the order in which the args are passed:
    ; RDI, RSI, RDX, RCX, R8, R9. So,
    
    ; RSI - size of array
    ; RDI - the pointer to data.

    ; let's use r9 and r9 for indexes as it will be easier to
    ; distinuish them
    mov r8, 1

outer_loop:
    mov r10d, [rdi + 4 * r8] ; key = data[i]
    mov r9, r8               ; j = i - 1
    jmp inner_loop
    
inner_loop:
    ; decrements j, checks whether it is >= than 0 and procceeds with loop
    sub r9, 1
    cmp r9, 0
    jo inner_loop_end ; jumps if overflow has happened


    cmp [rdi + 4 * r9], r10d           ; data[j] > key
    
    jbe inner_loop_end      ; if data[j] <= key, inner loop should be terminated,
                            ; otherwise, increment loop vars and procceed
    

    mov r11d, [rdi + 4 * r9] ; data[j + 1] = data[j]
    mov [rdi + 4 * r9 + 4], r11d

    jmp inner_loop

inner_loop_end:
    mov [rdi + 4 * r9 + 4], r10d ; data[j + 1] = key

    ; increments variable i and proceeds with the loop
    ; (or) terminates it
    add r8, 1
    cmp r8, rsi
    jl outer_loop
    je outer_loop_end

outer_loop_end:
    add rsp, 16 ; restore the stack
    pop rbp     ; restore rbp
    ret         ; return from the function
