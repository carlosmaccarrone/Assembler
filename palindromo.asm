.8086
.model small
.stack 100h
.data
			TEXTO DB 10 DUP (' '),'$'
			CARTEL1 DB "Ingrese una palabra cualquiera: ",'$'
			CARTEL2 DB "La palabra es palindroma",'$'
			CARTEL3 DB "La palabra no es palindroma", '$'
			SALTO DB " ",0DH,0AH,'$'
			
.code
main proc
            mov AX, @DATA
			mov DS, AX
			mov BX,0
			xor BX,BX
			
			mov ah,9
			mov DX,offset cartel1
			int 21H
			
UNO:
		mov AH,1
		int 21H
		cmp AL, '$'
		je DOS
		mov [BX+Offset texto], AL
		ADD BX, 1
		jmp UNO
		
DOS:
			dec BX
			mov DI, 0
TRES:
			mov AL, [DI+offset texto]
			cmp AL, [BX+offset texto]
			jne NOES
			cmp DI, BX
			jg ESPA
			inc DI
			dec BX
			jmp TRES
			
ESPA:
			mov ah,9
			mov DX,offset salto
			int 21H
			
			mov ah,9
			mov DX, offset cartel2
			int 21H
			jmp FINPG
NOES:
			mov ah,9
			mov DX,offset salto
			int 21H
			
			mov ah,9
			mov DX,offset cartel3
			int 21H
			
FINPG:
			mov AX,4C00H
			int 21H
endp
end main
			

			
		
			
			