%include "mac.inc"

section .data
newline db 0x0d, 0xa
O_RDONLY equ 0
O_WRONLY equ 1
O_RDWR equ 2
count dd 0
m db 0

section .bss
descriptor resb 4
buffer resb 100

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
	mov edx, 100
	int 0x80

	add dword[count], eax
	cmp eax, 100
	je for

	mov edx, 0
k:
        cmp al, 0
        je o
        inc edx
        mov bl, 10
        div bl
        push ax
        xor ah, ah
        jmp k
o:
        mov ecx, edx
l:
        pop ax
        push ecx

        add ah, 0x30
        mov [m], ah

        print m, 1

        pop ecx
	loop l

	print newline, 2
_exit:
	mov eax , 6 ; sys_close
        mov ebx , [descriptor]
        int 0x80
        exit

