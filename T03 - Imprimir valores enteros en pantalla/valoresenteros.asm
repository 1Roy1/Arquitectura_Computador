;Programa que imprime valores eneteros en pantalla
; author: ROy
; fecha: 20240306

%include 'stdio32.asm'

SECTION .data
        msg1    db      'Numero con printInt(1425):', 0
        msg2    db      'Numero con printIntLn(12111): ', 0
	msg3	db	'', 0
SECTION .bss
        cadena  resb    100

SECTION .text
        global _start

_start:
        mov     eax, msg1
        call    strPrintLn
        mov     eax, 1425
        call    printInt
	mov	eax, msg3
	call    strPrintLn
        mov     eax, msg2
        call    strPrintLn

        mov     eax, 12111
        call    printIntLn

        call    Quit


