%ifndef _findAPKFunc
%define _findAPKFunc

section .data
	seratus_ dd 100

section .bss
	_ax2 resd 1
	_bx1 resd 1
	_cx0 resd 1
	tempd_ resd 1
	_x1 resd 1
	_x2 resd 1
	temp_ resd 1
	temp2_ resd 1

section .text

findAPK:
	mov dword[_ax2], eax
	mov dword[_bx1], ebx
	mov dword[_cx0], ecx

	; mencari b kuadrat
	mov eax, [_bx1]
	mul eax			
	mov dword[temp_],eax

	;mencari 4ac
	mov eax, [_ax2]
	mov ebx, 4	
	mul dword[_cx0]
	mul ebx

	;mencari b^2 - 4ac
	mov ebx, [temp_]
	sub ebx, eax


	;mencari akar b^2 - 4ac
	mov eax, ebx
	call findSqr ;panggil fungsi find sqr
	cmp eax, -1 ;Apakah -1?
	je _imajinerAKP ;jump ke imajiner

	mov dword[tempd_], ebx

	;mencari -b
	mov eax, [_bx1]
	mul dword[seratus_]
	mov ebx, -1
	mul ebx
	mov dword[temp_], eax

	;mencari 2a
	mov eax, 2
	mul dword[_ax2]
	mov dword[temp2_], eax

nilai_x1: ; (-b - akar (b^2 -4ac))/2a
	mov eax, [temp_]
	sub eax, [tempd_]
	mov edx, 0
	cdq
	idiv dword[temp2_]
	mov dword[_x1], eax

nilai_x2: ; (-b + akar (b^2 -4ac))/2a
	mov eax, [temp_]
	add eax, [tempd_]
	mov edx, 0
	cdq
	idiv dword[temp2_]
	mov dword[_x2], eax


_ExitAPK:
	mov eax, [_x1]
	mov ebx, [_x2]
	ret

_imajinerAKP:
	ret


%endif