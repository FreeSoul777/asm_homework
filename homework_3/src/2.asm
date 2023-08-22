%include "mac.inc"


section .bss
	a resb N
	b resb N
	hra resb N
	hrb resb N
	lra resb N
	lrb resb N
	ost resb N



section .data
	newline db 0x0d, 0xa
	N equ 4


	
section .text:

global _start	

_start:
	xor eax, eax

	input a, N
	cmp eax, 3
	jne la	
	
	mov ax, [a]
	sub ax, 0x3030
	mov [hra], ah
	mov [lra], al
	jmp q

la:
	mov al, [a]
	sub al, 0x30
	mov [hra], al

q:	
	xor eax, eax
	input b, N
	cmp eax, 3
	jne lb
	
	mov ax, [b]
	sub ax, 0x3030
	mov [hrb], ah
	mov [lrb], al
	jmp qq

lb:
	mov al, [b]
	sub al, 0x30
	mov [hrb], al

qq:
	call SumBCD
	
_exit:
	print newline, 2
	exit



SumBCD:
        mov al, [lra]
        mov ah, [lrb]
        mov cl, [hra]
        mov ch, [hrb]

        adc al, ah
        daa

        adc cl, ch
        cmp cl, 10
        jl l

        inc al
        sub cl, 10
l:
        cmp al, 10
        jl ll

        cmp al, 10
        jne j
        sub al, 10
        jmp jj

j:
        sub al, 16

jj:
        add al, 0x30
        add cl, 0x30
        mov dl, 0x31

        mov [a], al
        mov [ost], cl
        mov [b], dl

        print b, 1
        print a, 1
        print ost, 1
        jmp e

ll:
        cmp al, 0
        jne m
        add cl, 0x30
        mov [a], cl

        print a, 1
        jmp e
m:
        add al, 0x30
        add cl, 0x30

        mov [b], al
        mov [a], cl

        print b, 1
        print a, 1

e:
        ret


