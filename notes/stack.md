## Stack

- поточна вершина стеку знаходиться в SP/ESP/RSP

push val:
    mov [ESP - 4], val;
- стек росте вниз

pushf - 

push EAX
push [EDI]
push 333h

// забирає значення в регістр або пам'ять
pop [ESI]
pop EBX

call, ret

function call:
// push the ret pointer on the stack
push ebp
mov ebp, esp
call [func]
pop ebp 
ret

## Угода про виклики
- аргументи передаються через стек
- цілі числа та вказівники повертаються в EAX
- EAX, ECX, EDX можуть бути вільно змінювані
- всі інші повинні бути збереженими та відновленими
- за очистку стеку відповідає код, що викликає цю функцію

Example:
void fn(int a, int b, int c);

sub esp, 10h // стек повинен бути вирівняним на 16
mov [esp + 8], 3
mov [esp + 4], 2
mov [esp], 1
call <fn>  // here call will put address of return address into esp, and then it will used by <fn> when the `ret` will be called

Тепер подивимось зі сторони функції

push ebp // upper func also has some state stored in this ebp, therefore
// we need to save it somewhere
mov ebp, esp

; a = a + b + c
mov eax, DWORD PTR [ebp + 0xOC]
mov edx, DWORD PTR [ebp + 0x08]
add eax, edx
add eax, DWORD PTR [ebp + 0x10]
mov DWORD PTR[ebp + 0x08], eax

// відновити старе значення ebp для зовнішньої функції
pop ebp
ret

## Кадр стеку
push ebp // зберігаємо  ebp
mov ebp, esp // налаштовуємо кадр стеку
....

pop ebp
ret

- esp потрібно зберігати для зручної індекссації (адже він змінювтиметься посеред функції)
- локальна змінна: sub esp, 0x10


