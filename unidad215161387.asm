SYS_SALIDA equ 1
SYS_LEE equ 3
SYS_PRINT equ 4
STDIN equ 0
STDOUT equ 1

segment .data
  mensaje1 db "Ingrese un numero(1-9):"
  lenMensaje1 equ $- mensaje1
	mensaje2 db "1"
	lenMensaje2 equ $- mensaje2

segment .bss
	teclado resb 1
	numero resb 2

section  .text
	global _start
_start:

mov eax, SYS_PRINT
mov ebx, STDOUT
mov ecx, mensaje1
mov edx, lenMensaje1
int 0x80

mov eax, SYS_LEE
mov ebx, STDIN
mov ecx, teclado
mov edx, 1
int 0x80



mov esi,[teclado]
sub esi,'0'

iteracion:
    mov edx,0
    mov eax,esi
    mov ecx,2
		div ecx
    cmp edx,0
    je par
		jmp impar

impar:
		add esi,'0'
  	mov [numero],esi
		sub esi,'0'

		mov eax, SYS_PRINT
		mov ebx, STDOUT
		mov ecx, numero
		mov edx, 2
		int 0x80

		mov eax,esi
    mov edx,0
    mov ebx,3
    mov ecx,1

    mul ebx
    add eax,ecx
		mov esi,eax
		jmp continue

par:
	add esi,'0'
  mov [numero],esi
	sub esi,'0'

	mov eax, SYS_PRINT
	mov ebx, STDOUT
	mov ecx, numero
	mov edx, 2
	int 0x80


	mov eax,esi
  mov edx,0
  mov ecx,2
  div ecx
  mov esi,eax
	jmp continue

continue:
cmp esi,1
jne iteracion

mov eax, SYS_PRINT
mov ebx, STDOUT
mov ecx, mensaje2
mov edx, lenMensaje2
int 0x80

salir:
  mov eax, SYS_SALIDA
	xor ebx, ebx
	int 0x80
