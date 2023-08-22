%include "mac.inc"


section .data
newline db 0x0d, 0xa
O_RDONLY equ 0
O_WRONLY equ 1
O_RDWR equ 2
sum db 4 DUP (0)


section .bss
fd resb 4
buffer resb 2


section .text

global _start

_start:
	pop ebx ; argc
        pop ebx ; argv [0]
        pop ebx ; argv [1] 

        mov eax , 5 ; sys_open
        mov ecx , 0 ; O_RDWR = 0
        mov edx , 2 ;
        int 0x80
        mov [fd], eax

p:	lea esi, sum
	mov ecx, 0

l:	push ecx
;	print sum, 4
;	print newline, 2
	mov eax , 3 ; sys_read
        mov ebx , [ fd ]
        mov ecx , buffer
        mov edx , 1
        int 0x80

	cmp eax, 0
	je _exit

	pop ecx
	mov al, [esi]
	mov ah, [buffer]
	xor al, ah
	mov [esi], al
	inc ecx
	inc esi

	cmp ecx, 4
	je p
	
	jmp l

_exit:
	mov ecx, 4
	lea esi, sum
	for:
		push ecx
		mov edi, buffer
		mov ax, [esi]
		call byte_to_hex_str
		inc esi
		print buffer, 2
		pop ecx
		loop for
	print newline, 2
        mov eax , 6 ; sys_close
        mov ebx , [fd]
        int 0x80
        exit


byte_to_hex_str:
    push ax
    mov ah,al
    shr al,4
    call to_hex_digit
    mov [edi],al
    inc edi
    mov al,ah
    and al,0Fh
    call to_hex_digit
    mov [edi],al
    inc edi
    pop ax
    ret



to_hex_digit:
    add al,'0' 
    cmp al,'9' 
    jle thd_end
    add al,7
thd_end:
    ret

