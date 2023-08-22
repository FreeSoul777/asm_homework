%include "mac.inc"

section .data
char db ' ', '|', 0x2e
newline db 0x0d, 0xa
O_RDONLY equ 0
O_WRONLY equ 1
O_RDWR equ 2


section .bss

descriptor resb 4
buffer resb 16
bufsize resb 0
buf resb 2

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
	mov eax , 3 ; sys_read
	mov ebx , [descriptor]
	mov ecx , buffer
	mov edx , 16
	int 0x80

	mov [bufsize], eax
	cmp eax, 0
	je _exit

	lea esi, [char + 1]
	print esi, 1 
	mov ecx, [bufsize]
	mov esi, buffer	
	lea edi, [char + 2]
p:
	push ecx
	cmp byte [esi], 0xa
	jne b
	print edi, 1	
	jmp c
	;mov byte [esi], '.'

b:	print esi, 1
c:	inc esi
	pop ecx
	loop p

	mov ecx, 16
	sub ecx, [bufsize]
	jz o 
g:
	push ecx
	print char, 1
	pop ecx
	loop g

o:	lea esi, [char + 1]
	print esi, 1

	mov ecx, [bufsize]
	mov esi, buffer
l:	
	push ecx
	print char, 1
	mov edi, buf
	mov ax, [esi]
	call byte_to_hex_str

	print buf, 2
	inc esi
	pop ecx
	loop l

	print newline, 2
	jmp for
	
_exit:
	mov eax , 6 ; sys_close
	mov ebx , [descriptor]
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
