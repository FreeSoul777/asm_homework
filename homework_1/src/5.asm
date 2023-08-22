%include "mac.inc"

global _start

section .data
len: db 20
a: times 20 db 0
	
	
section .text:

_start:
	
	input a, 20

	
	cmp byte [a + 3], 0
	je r
	cmp byte [a + 3], 0x0D
	jle r
	mov al, byte[a + 0]
	mov ah, byte[a + 3]
	mov byte[a + 0], ah
	mov byte[a + 3], al
	
	cmp byte [a + 7], 0
	je r
	cmp byte [a + 7], 0x0D
        jle r
	mov al, byte[a + 2]
	mov ah, byte[a + 7]
	mov byte[a + 2], ah
	mov byte[a + 7], al

r:	print a, 20
	
	exit
