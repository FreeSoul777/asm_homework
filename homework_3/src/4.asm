%include "mac.inc"


section .data
gamma db '1', '2', '3', '4'
newline db 0x0d, 0xa

section .bss
buffer resb 1
result resb 101
m resb 1

section .text
global _start

_start:
	xor dx, dx
	lea esi, result
for:
	push dx
	input buffer, 1
	pop dx
	cmp byte[buffer], 0xa
	je _exit	
	
	mov ax, dx
	mov bl, 4
	div bl

	inc dx

	xor ecx, ecx
	mov cl, ah
l:
	mov al, byte[buffer]
	mov ah, byte[gamma+ecx]
	xor al, ah 
	mov [esi], al
	inc esi
	jmp for

_exit:
	mov eax, 4
        mov ebx, 1
        mov ecx, result
        int 0x80

	print newline, 2
	exit
