%macro print 2
  mov eax , 4
  mov ebx , 1
  mov ecx , %1
  mov edx , %2
  int 0x80
%endmacro


%macro input 2
	mov     eax,    3
        xor     ebx,    ebx
        mov     ecx,    %1
        mov     edx,    %2
        int     0x80
%endmacro


%macro exit 0
	mov     eax,    1
        xor     ebx,    ebx
        int     0x80
%endmacro

