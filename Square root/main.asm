; Programmed by Ryan Baskara (G64130055) Setiawan (G64130069)

%include "scanNum.asm"
%include "printChar.asm"
%include "printStr.asm"
%include "printFloat.asm"
%include "fungsiSqr.asm"
%include "printBiner.asm"
%include "fungsiAPK.asm"
%include "readFile.asm"

section .data
	msg1 db "(sqr) ",0
	msg2 db "Hasil desimal : ",0
	msg3 db "Hasil biner : ",0
	msg4 db "Bilangan imajiner ",10,0
	msg5 db "(apk) ",0
	msg6 db "X1 = ",0
	msg7 db "X2 = ",0
	msg8 db "sqr",0
	len8 equ $-msg8
	msg9 db "Masukkan koefisien dari AX^2 BX C ",10
	msg10 db "exit",0
	len10 equ $-msg10
	file_name db "readme.txt"
	
section .bss
	
	hasil resd 1
	hasilfloat resd 1	
	ax2 resd 1
	bx1 resd 1
	cx0 resd 1
	x1 resd 1
	x2 resd 1
section .text
	global main

main:
	nop 
	push ebp
	mov ebp, esp

mulai:
	cmp dword[ebp+4],2
	jne readmeText

	mov esi, [ebp+12]
	mov edi, msg8
	mov ecx, len8
	cld
	repe cmpsb
	jecxz fungsi_Sqr
	jmp Fungsi_APK

fungsi_Sqr:

	mov eax, msg1 ;cetak (sqr), pindah alamat msg1 ke eax
	call printString ;panggil fungsi prinStr

	call scanNum ;baca angka
	;mov dword[val], eax ; pindah ke variabel val

	call findSqr ;panggil fungsi find sqr

	cmp eax, -1 
	je imajiner
	mov dword[hasil], eax
	mov dword[hasilfloat], ebx

	cetak:
		mov eax, msg2 ;pindah string "Hasil desimal : " ke eax
		call printString

		mov eax, [hasilfloat] ;hasil akhir masuk ke eax
		mov ebx, 1
		call printFloat ;panggil fungsi printFloat
		
		mov al, 10 ;newline
		call printChar ;panggil fungsi printChar

		mov eax, msg3 ;pindah alamat string "Hasil biner : " ke eax
		call printString

		mov eax, [hasil] ; mov hasil bil bulat ke eax
		call printBiner ; panggil fungsi print biner

		mov al,10 ;newline
		call printChar

		jmp mulai


Fungsi_APK:
	mov eax, msg5 ;cetak (apk), pindah alamat msg5 ke eax
	call printString ;panggil fungsi prinStr

	call scanNum ;baca angka
	mov dword[ax2], eax ; pindah ke variabel val
	call scanNum ;baca angka
	mov dword[bx1], eax ; pindah ke variabel val
	call scanNum ;baca angka
	mov dword[cx0], eax ; pindah ke variabel val

	mov eax, [ax2]
	mov ebx, [bx1]
	mov ecx, [cx0]
	call findAPK
	cmp eax, -1
	je imajiner

	mov dword[x1], eax
	mov dword[x2], ebx

	mov eax, msg6 ;cetak "X1 = ", pindah alamat msg6 ke eax
	call printString ;panggil fungsi prinStr

 	mov eax, [x1] ;hasil akhir masuk ke eax
 	mov ebx, 1
 	call printFloat ;panggil fungsi printFloat

 	mov al, 10 ;newline
 	call printChar ;panggil fungsi printChar

 	mov eax, msg7 ;cetak "X2 = ", pindah alamat msg7 ke eax
	call printString ;panggil fungsi prinStr

 	mov eax, [x2] ;hasil akhir masuk ke eax
 	mov ebx, 1
 	call printFloat ;panggil fungsi printFloat

 	mov al, 10 ;newline
 	call printChar ;panggil fungsi printChar

	jmp mulai

imajiner:
	mov eax, msg4 
	call printString
	jmp exit

readmeText:
	mov eax, file_name
	call readFile
exit:
	mov eax, 1
	mov ebx, 0
	int 0x80
