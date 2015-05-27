; Programmed by Ryan Baskara (G64130055) Setiawan (G64130069)

;Fungsi print float 2 angka belakang koma

%ifndef _printFloatFunc
%define _printFloatFunc

_printFloatStrLen equ 255

section .data
	; Angka 10
	_printFloatSepuluh dd 10


section .bss
	; Tempat penampungan string yang akan dicetak
	_printFloat resb _printFloatStrLen
	_cekNegativ resd 1

section .text

printFloat:
	
	; Reset ecx -> index terakhir string yang akan dicetak
	mov ecx, _printFloatStrLen
	sub ecx, 1
	mov dword[_cekNegativ],0 ;anggap kondisi awal adalah positif

	cmp eax, 0
	jl _Negativ
	; Periksa apakah eax bernilai 0?
	 cmp eax, 0
	 je _FZero
	 ; Periksa apakan eax memiliki 1 digit?
_Cek:
	cmp eax, 10
	jl _1digit
	;periksa apakah eax memiliki 2 digit?
	cmp eax, 100
	jl _2digit
	jmp _lebih

_Negativ:
	mov dword[_cekNegativ],1
	mov ebx, -1
	imul ebx
	jmp _Cek

_1digit:
	mov edx, eax
	add dl, '0' ;ambil digit angka terakhir untuk diubah menjadi string
	mov byte[_printFloat+ ecx], dl ;angka kedua setelah koma dimasukkan dl
	sub ecx, 1
	mov byte[_printFloat+ ecx], '0' ; angka selanjutnya nol
	sub ecx, 1
	mov byte[_printFloat+ ecx], '.'
	sub ecx, 1
	mov byte[_printFloat+ ecx], '0'
	sub ecx, 1
	cmp dword[_cekNegativ], 1
	je _tandaNegativ
	jmp _printFloatCetakNext

_2digit:
	mov edx, 0
	div dword[_printFloatSepuluh]
	add dl, '0' ;digit terakhir diubah menjadi string
	mov byte[_printFloat+ ecx], dl ;angka kedua setelah koma
	sub ecx, 1
	add al, '0' ;digit pertama diubah menjadi string
	mov byte[_printFloat+ ecx], al ;angka pertama setelah koma
	sub ecx, 1
	mov byte[_printFloat+ ecx], '.'
	sub ecx, 1
	mov byte[_printFloat+ ecx], '0'
	sub ecx, 1
	cmp dword[_cekNegativ], 1
	je _tandaNegativ
	jmp _printFloatCetakNext

_lebih:
	mov edx, 0
	div dword[_printFloatSepuluh]
	add dl, '0' ;digit terakhir diubah ke string
	mov byte[_printFloat+ ecx], dl ;angka kedua setelah koma
	sub ecx, 1
	mov edx, 0 
	div dword[_printFloatSepuluh]
	add dl, '0' ;digit ked diubah menjadi string
	mov byte[_printFloat+ ecx], dl ;angka pertama setelah koma
	sub ecx, 1
	mov byte[_printFloat+ ecx], '.' 
	sub ecx, 1

_DepanKoma:
	mov edx, 0
	div dword [_printFloatSepuluh]

	; konversi int to string
	add dl, '0'
	mov byte [_printFloat + ecx], dl

	sub ecx, 1 ;index -1

	cmp eax, 0 ;cek eax apakah nol
	jne _DepanKoma

	cmp dword[_cekNegativ], 1
	jne _printFloatCetakNext


_tandaNegativ:
	mov byte [_printFloat + ecx], '-'
	sub ecx, 1
	jmp _printFloatCetakNext

_FZero:
	mov byte [_printFloat + ecx], '0'
	sub ecx, 1

_printFloatCetakNext:

	; menghitung panjang angka yang dicetak
	mov edx, _printFloatStrLen ;panjang maksimum
	sub edx, ecx
	sub edx, 1

	; mencari alamat indeks pertama yang akan dicetak
	add ecx, _printFloat
	add ecx, 1

	; perintah print ke stdout
	mov eax, 4
	mov ebx, 1
	int 0x80

_FloatPrintExit:

	ret


%endif