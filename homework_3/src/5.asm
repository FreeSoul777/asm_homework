%include "mac.inc"

section .data
newline db 0x0d, 0xa
O_RDONLY equ 0
O_WRONLY equ 1
O_RDWR equ 2
count dd 0
flag db 0

section .bss
descriptor resb 4
buffer resb 1

section .text

global _start

_start:
        pop ebx ; argc
        pop ebx ; argv [0]
        pop ebx ; argv [1]

        mov eax , 5 ; sys_open
        mov ecx , 0 ; O_RDONLY = 0
        mov edx , 2 ;
        int 0x80
        mov [descriptor], eax

for:
        mov eax, 3   ;sys_read
        mov ebx, [descriptor]
        mov ecx, buffer
        mov edx, 1
        int 0x80

	cmp eax, 0
	je _exit

	cmp byte [buffer], 0xa
	jne l
      
	add byte [flag], 1
	jmp g

l:	cmp byte [flag], 0
	je g

	cmp byte [flag], 2
	je _exit

	print buffer, 1
g:
	jmp for
 
_exit:
	print newline, 2
        mov eax , 6 ; sys_close
        mov ebx , [descriptor]
        int 0x80
        exit

