
include 'cpu/x64.inc'
use64

MachO.Settings.FileType equ MH_OBJECT
MachO.Settings.ProcessorType equ CPU_TYPE_X86_64
MachO.Settings.ProcessorSubtype equ CPU_SUBTYPE_X86_64_ALL
include 'format/macho.inc'

section '__TEXT':'__text'

  public _func

  ; struct linked_list_node* func (struct linked_list_node* node);
  _func:
    push rbp
    mov rbp, rsp
    sub rsp, 16 ; aligning of stack

    ; RDI - curr - the pointer to first elm of linked list.
    ; r9 - prev
    ; r8 - curr
    ; rax - next

    mov r9, 0       ; prev = NULL 
    mov r8, rdi
    mov rax, 0
    jmp nxt_elm     ; has no effect, just for readability 

nxt_elm:
    cmp r8, 0       ; while curr
    je end_reached

    mov rax, [r8 + 8]   ; dereference address stored in r10 and 
                        ; stored it back in the rax
                        ; remember that the struct is aligned by the
                        ; greatest its field, so we need to add here 8
                        ; next = curr.next

    mov [r8 + 8], r9   ; curr.next = prev

    mov r9, r8      ; prev = curr
    mov r8, rax     ; curr = next
    jmp nxt_elm

end_reached:
    mov rax, r9   ; return value into rax (or rdx if we need more)

    add rsp, 16     ; restore the stack
    pop rbp         ; restore rbp
    ret             ; return from the function
