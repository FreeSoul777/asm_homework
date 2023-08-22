%include "mac.inc"

global  _start
 
section .bss 
%define bufsize 2
buffer  resb  bufsize

section .data
no: db "NO, not is latin symbol", 0xa, 0
n: equ $-no
 
SECTION .text
 
_start:
        input buffer, bufsize-1           

	mov	al, 0xa
	mov	[buffer + 1], al 
 
	mov 	al, 	[buffer] 
    	and 	al,	0b11011111    
	cmp	al, 	'Z'
	je	c

	sub     al,     'A'
    	cmp 	al,	'Z'-'A' 
    	ja 	a
	
	mov 	al, 	[buffer]
	add 	al, 	1
	mov 	[buffer], 	al
c:	print buffer, bufsize
	jmp b
a:
	print no, n
b:      exit
