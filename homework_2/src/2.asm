%include "mac.inc"


section .data

newline db 0x0d, 0xa
O_RDONLY equ 0
O_WRONLY equ 1
O_RDWR equ 2


section .bss

nfd resb 4
fd resb 4
buffer resb 100


section .text

global _start

_start:
	pop ebx ; argc
        pop ebx ; argv [0]
        pop ebx ; argv [1] ; to

        mov eax , 5 ; sys_open
        mov ecx , 1 ; O_WRONLY = 0
        mov edx , 2 ;
        int 0x80
        mov [nfd], eax

l: 	
	pop ebx ; argv [i++]; from
	cmp ebx, 0
	je _exit

	mov eax, 5
	mov ecx, 0
	mov edx, 2
	int 0x80
	mov [fd], eax

p:	mov eax , 3 ; sys_read
	mov ebx , [fd]
	mov ecx , buffer
	mov edx , 100
	int 0x80

	cmp eax, 0
	jle fclose

	mov edx, eax
	print buffer, edx

	mov eax , 4 ; sys_write
	mov ebx , [nfd]
	mov ecx , buffer
	int 0x80

	jmp p
	
fclose:
	mov eax, 6
	mov ebx, [fd]
	int 0x80
	jmp l



_exit:
	mov eax , 6 ; sys_close
        mov ebx , [nfd]
        int 0x80

        exit

