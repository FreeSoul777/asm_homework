%include "mac.inc"


section .data
gamma db 'a', 'b', 'c', 'd'


section .bss
buffer resb 1
result resb 100

section .text
global _start

_start:
	xor dx, dx
	lea esi, result
for:
	push dx
	input buffer, 1
	pop dx
	inc dx
	cmp byte[buffer], 0xa
	je _exit	
	
	mov ax, dx
	mov bl, 4
	div bl

	mov ch, ah
l:
	mov al, byte[buffer]
	mov ah, byte[gamm+ch]
	xor al, ah 
	mov [esi], al
	inc esi

_exit:
	mov eax, 4
        mov ebx, 1
        mov ecx, result
        int 0x80
	exit
