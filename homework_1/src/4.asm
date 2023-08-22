BITS 32
%include "mac.inc"
global  _start

section .data
a  db    0, 0xa
b  db    0, 0xa
SECTION .text

_start:
	input a, 1
	input b, 1
	input b, 1

	mov al, [a]
	sub al, 0x30
	mov bl, [b]
	sub bl, 0x30
	aad
	div bl

	add ah, 0x30
	add al, 0x30
	mov [a], ah
	mov [b], al
	
	print b, 2
	exit
