%ifndef _printBinerFunc
%define _printBinerFunc

_binerStrLen equ 255

section .data
	; Angka 2
	_dua dd 2


section .bss
	; Tempat penampungan string yang akan dicetak
	_biner resb _binerStrLen

section .text

printBiner:

	mov ecx, _binerStrLen	
	sub ecx, 1 ;index paling akhir di array biner
	mov byte[_biner+ecx],0 
l1:
	
	;looping selama eax ga 0
	sub ecx,1 ;counter -1
	mov edx, 0
	div dword[_dua] 
	add dl,'0' ;mengubah number ke string
	mov byte [_biner+ecx],dl ;masuk ke biner dengan index ecx
	
	cmp eax,0 
	jne l1 ;kalau belum nol kembali lagi ke L1
	

_printBiner:

	mov eax, _biner
	add eax, ecx
	call printString
	

_ExitBiner:
	ret


%endif