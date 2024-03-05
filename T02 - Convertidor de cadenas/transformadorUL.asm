; Convertir una cadena en mayusculas y minusculas
; autor: Roy
; fehca: 20240226

%include 'stdio32.asm'

SECTION .data
	msg1	db	'Ingrese una palabra:', 0
	msg2	db	'Palabra en Mayusculas: ', 0
	msg3	db	'Palabra en Minusculas:', 0

SECTION	.bss
	cadena	resb	100

SECTION	.text
	global _start

_start:
	mov	eax, msg1
	call	strPrint
	mov	ebx, cadena
	call	strInput
	mov	eax, msg2
	call	strPrint
	mov	eax, cadena
	call	upCase
	mov	eax, msg3
	call	strPrint
	mov 	eax, cadena
	call	lowCase
	call 	Quit
