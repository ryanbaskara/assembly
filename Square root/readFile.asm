
%ifndef _readFile
%define _readFile

section .data
	buffer_size equ 1000
section .bss
	fd_in resb 1
	info resb buffer_size
section .text

readFile:
	mov ebx, eax ;terima nama file

	;open file
	mov eax, 5	;system call number (sys_open)
	
	mov ecx, 0 ;for read only access
	mov edx, 0777	;read, write and execute by all
	int 0x80 ;call kernel
	mov [fd_in], eax	;eax contain return-val of the system

	;read from the file
	mov eax, 3 ; syscallnum (sys_write)
	mov ebx, [fd_in]
	mov ecx, info	
	mov edx, buffer_size 
	int 0x80

	;close the file
	mov eax, 6 ;syscallnum (sys_close)
	mov ebx, [fd_in]
	int 0x80

	;cetak readmeText
	mov eax,4
	mov ecx, info
	mov edx, buffer_size
	mov ebx,1
	int 0x80

	ret


%endif