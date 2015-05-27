
%ifndef _printString
%define _printString

section .data

section .bss

section .text

printString:
	mov ebx, 1 ;stdout
	; Reset pointer ecx dari parameter
	mov ecx, eax

_printStrLoop:

	; Periksa apakah sudah null?
	cmp byte [ecx], 0
	je _printStrExit
	
	; Cetak character
	mov eax, 4 ;sys_write
	mov edx, 1
	int 0x80

	; Add counter
	add ecx, 1

	jmp _printStrLoop

_printStrExit:

	ret


%endif