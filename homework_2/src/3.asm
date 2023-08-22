%include "mac.inc"

section .data
newline db 0x0d, 0xa
O_RDONLY equ 0
O_WRONLY equ 1
O_RDWR equ 2


section .bss
fd resb 4
buffer resb 1


section .text

global _start

_start:
	pop ebx ; argc
        pop ebx ; argv [0]
        pop ebx ; argv [1] 

        mov eax , 5 ; sys_open
        mov ecx , 2 ; O_RDWR = 0
        mov edx , 2 ;
        int 0x80
        mov [fd], eax

l:	mov eax , 3 ; sys_read
	mov ebx , [ fd ]
	mov ecx , buffer
	mov edx , 1
	int 0x80

	cmp eax, 0
	jle _exit

	mov eax, [buffer]

	cmp eax, 0x61
	jl a

	cmp eax, 0x7a
	jle b

	
	cmp eax, 0xe0
	jl a

b:	sub eax, 0x20
	mov [buffer], eax

	mov eax , 19
	mov ebx , [fd]
	mov ecx , -1
	mov edx , 1 ; SEEK_CUR
	int 0x80

	mov eax , 4 ; sys_write
	mov ebx , [ fd ]
	mov ecx , buffer
	mov edx , 1
	int 0x80

a:	print buffer, 1
	jmp l


_exit:
	mov eax , 6 ; sys_close
        mov ebx , [fd]
        int 0x80
	exit
