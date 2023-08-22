%include "mac.inc"

section .data
newline db 0x0d, 0xa
O_RDONLY equ 0
O_WRONLY equ 1
O_RDWR equ 2


section .bss
char resb 1
descriptor resb 4
buffer resb 1

section .text

global _start
_start:
        pop ebx ; argc
        pop ebx ; argv [0]
        pop ebx ; argv [1]

        mov eax , 5 ; sys_open
        mov ecx , 2 ; O_RDONLY = 0
        mov edx , 2 ;
        int 0x80
        mov [descriptor], eax

	mov byte [char], 195

	call fun

_exit:
        mov eax , 6 ; sys_close
        mov ebx , [descriptor]
        int 0x80
        exit




fun:
	for:
        mov eax , 3 ; sys_read
        mov ebx , [descriptor]
        mov ecx , buffer
        mov edx , 1
        int 0x80

        cmp eax, 0
        je l

        print buffer, 1

        mov al, 7
        mov cl, [char]
        mul cl
        add al, 17
        mov [char], al

        print char, 1
        print newline, 2

        mov eax , 19
        mov ebx , [descriptor]
        mov ecx , -1
        mov edx , 1 ; SEEK_CUR
        int 0x80

        mov eax , 4 ; sys_write
        mov ebx , [descriptor]
        mov ecx , char
        mov edx , 1
        int 0x80

        jmp for

l:
	ret
