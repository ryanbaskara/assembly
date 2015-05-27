;Fungsi find square root 2 digit angka dibelakang koma
;Ryan Baskara Putra (G64130055), M. Setiawan (G64130069)

%ifndef _fungsiSqr
%define _fungsiSqr

section .data
	_seratus dd 100
	_n dd 2

section .bss
	_hasilDesimal resd 1
	_hasilFloat resd 1
	_temp resd 1
	var_b resd 1
	_val resd 1
section .text

findSqr:
	mov dword[_val],eax

	cmp dword[_val], 0 ;bandingkan dengan nol
	jl _imajiner		;jika kurang dari nol maka jmp ke imajiner
	cmp dword[_val], 1 ;bandingkan dengan 1
	jge _fungsi_akar	;jika lebih besar dari 1 maka masuk fungsi akar
	mov dword[_hasilFloat],0
	mov dword[_hasilDesimal],0
	jmp _sqrExit

_fungsi_akar:

	mov ebx, 0

	mov ecx, [_val] ;_val masuk ke ecx
cek:
	add ebx, 1	;mencari pendekatan mulai dari 1
	mov eax, ebx

	mov edi, 1
	ha:
		inc edi
		mul ebx	;ebx du kuadratkan
		cmp edi, [_n]
		jl ha

	cmp eax, ecx ;bandingkan _hasilDesimal kuadrat dengan _val 
	jle cek  ;jka kurang dari atau sama dengan maka jmp cek
	
	;jika lebih dari _val
	sub ebx, 1 ;ebx dikurang 1 karena mencari x kuadrat yang 
				;hasilnya mendekati _val tetapi kurang dari _val  
	mov dword[_hasilDesimal], ebx ; _hasilDesimal yang didapat masuk ke variabel _hasilDesimal



;mencari 2 angka dibelakang koma
	
	;mencari b
	mov eax, [_hasilDesimal]
	mul eax
	mov ebx, [_val]
	sub ebx, eax
	mov dword[var_b], ebx

	;mencari b/2A
	mov eax, [var_b]
	mul dword[_seratus]	;b dikali 100
	mov ebx, [_hasilDesimal]
	mov edx, 0
	div ebx	;b dibagi A
	mov ebx, 2
	mov edx, 0
	div ebx	; b/2A
	mov dword[_temp], eax

	;mencari A + b / 2A 
	mov eax, [_hasilDesimal]
	mul dword[_seratus]
	add eax, [_temp]
	mov dword[var_b], eax

	;mencari (b/2A)kuadrat
	mov eax, [_temp]
	mul eax 

	;mencari ((b/2A)^2)/(A+b/2A)
	mov ebx, [var_b]
	mov edx, 0
	div ebx
	;mencari ((b/2A)^2)/2(A+b/2A)

	mov ebx, 2
	mov edx, 0
	div ebx

	;mencari (A+b/2A)-((b/2A)^2)/2(A+b/2A))
	mov ebx, [var_b]
	sub ebx, eax
	mov dword[_hasilFloat], ebx

_sqrExit:
	mov eax, [_hasilDesimal]
	mov ebx, [_hasilFloat]
	ret
_imajiner:
	mov eax, -1
	ret


%endif