;bloque de funciones para entrada y salida estandar
; autor: Roy
; fecha:20240223

;-------------------int strLen(cadena)-------
; recibe cadena en eax y devuelve resultado en eax
strLen:
	push ebx
	mov ebx, eax

sigCaracter:
	cmp byte[eax], 0
	jz finStrLen
	inc eax
	jmp sigCaracter
finStrLen:
	sub eax, ebx
	pop	ebx
	ret
;--------------strPrint*(cadena)
; imprime cadena en pantalla, recibe cadena en eax
strPrint:
	push	edx
	push	ecx
	push	ebx
	push	eax

	call strLen
	mov edx, eax
	pop	eax
	mov 	ecx, eax
	mov 	ebx, 1
	mov 	eax, 4
	int 	80h

	pop ebx
	pop ecx
	pop edx
	ret
;--------------------strPrintLn(cadena)----------
; imprime cadena en pantalla, la cadena se recibe en ax
; agrega salto de linea en la impresion
strPrintLn:
	call strPrint
	push eax
	mov eax, 0Ah	;eax= 0Ah
	push	eax	;colocamos el valor de eax en pila
	mov eax, esp 	;eax apunta a esp (posicion de inicio de pila)
	call strPrint
	pop eax
	pop eax
	ret

;--------------------strInput
; recibe un parametro como cadena en eax
strInput:
	push 	edx
	push	ecx
	push	ebx
	push	eax


	mov	edx, eax
	mov	ecx, ebx
	mov	ebx, 0
	mov	eax, 3
	int	80h


	pop 	eax
	pop	ebx
	pop	ecx
	pop 	edx
	ret
;-------------------------Recibe cadena y la pasa a mayusculas
upCase:
	push	ebx
	push	eax
	mov	ebx, eax

Mayusculas:
	cmp	byte[ebx], 0
	jz	finMayusculas
	cmp	byte[ebx], 32
	je	espaciomayusculas
	cmp	byte[ebx], 'z'
	jg	espaciomayusculas
	cmp	byte[ebx], 'a'
	jge	convertirMayusculas
	inc	ebx
	jmp	Mayusculas

convertirMayusculas:
	sub	byte[ebx], 32
	inc	ebx
	jmp	Mayusculas

espaciomayusculas:
	inc	ebx
	jmp	Mayusculas

finMayusculas:
	call	strPrintLn
	pop	ebx
	pop	eax
	int	80h
	ret
;----------------------recibe cadena y convierte en minusculas
lowCase:
	push	ebx
	push	eax
	mov	ebx, eax

Minusculas:
	cmp	byte[ebx], 0
	jz	finMinusculas
	cmp	byte[ebx], 32
	je	espaciominusculas
	cmp	byte[ebx], 'A'
	jl	espaciominusculas
	cmp	byte[ebx], 'Z'
	jle	convertirMinusculas
	inc	ebx
	jmp	Minusculas

convertirMinusculas:
	add	byte[ebx], 32
	inc	ebx
	jmp	Minusculas
espaciominusculas:
	inc	ebx
	jmp	Minusculas

finMinusculas:
	call	strPrintLn
	pop	ebx
	pop	eax
	int	80h
	ret
;----------------Quit
Quit:
	mov ebx, 0
	mov eax, 1
	int 80h
	ret
;-------------------printint--- imprime una cadena en un numero entero
Division:
	inc	ecx
	xor	edx, edx
	idiv	ebx
	push	edx
	cmp	eax, 0
	jne	Division

Concatenar:
	cmp	ecx, 0
	jz	Finalizar
	dec	ecx
	pop	edx
	add	edx, 48
	push	edx
	mov	eax, esp
	call	strPrint
	pop	eax
	xor	eax, eax
	jmp	Concatenar

Finalizar:
	ret

printInt:
	push   eax
        push    ecx
        push    ebx

	mov 	ebx, 10
        xor     ecx, ecx
        call   Division
        call   Concatenar

        pop     ebx
        pop     ecx
	pop	eax
        ret

;--------------------------------------------------- printIntLn(numero)
; imprimir un numero por separado

Division2:
        inc     ecx
        xor     edx, edx
        idiv    ebx
        push    edx
        cmp     eax, 0
        jne     Division2

Concatenar2:
        cmp     ecx, 0
        jz     Finalizar2
        dec     ecx
        pop     edx
        add     edx, 48
        push    edx
        mov     eax, esp
        call    strPrint
        pop     eax
        xor     eax, eax
        jmp     Concatenar2

Finalizar2:
        ret
printIntLn:

        push    eax
        push    ecx
        push    ebx

        mov     ebx, 10
        xor     ecx, ecx


        call   Division2
        call   Concatenar2
	
	mov eax, 0Ah    ;eax= 0Ah
        push    eax     ;colocamos el valor de eax en pila
        mov eax, esp    ;eax apunta a esp (posicion de inicio de pila)
        call strPrintLn 
	
        pop     ebx
        pop     ecx
        pop     eax
	pop 	eax
        ret

; -------------------------strInvertir(cadena)-------------
strInvertir:
	push	ebp
	mov	ebp, esp
	mov	eax, [ebp + 8]

cadenaEnPila:
	mov	bl, byte[eax]
	cmp	bl, 0
	jz	finCadenaEnPila

	push	bx
	inc	eax
	jmp	cadenaEnPila

finCadenaEnPila:
	mov	eax, [ebp + 8]
	jmp	invertirCadena

invertirCadena:
	pop	bx
	mov	byte[eax], bl
	cmp	bl, 0
	jz	finInvertirCadena
	inc	eax
	jmp	invertirCadena

finInvertirCadena:
	leave
	ret
