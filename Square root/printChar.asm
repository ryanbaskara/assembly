
%ifndef _printChar
%define _printChar

section .data

section .bss
	_char resb 1

section .text

printChar:

	mov byte[_char], al
	mov eax, 4
	mov ebx, 1
	mov ecx, _char
	mov edx, 1
	int 0x80

	ret


%endif