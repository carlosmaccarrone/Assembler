.8086
.model small
.stack 100H
.data
			texto DB 100 dup(' '),'$'
			cartel1 DB "Ingrese un texto: ",'$'
			cartel2 DB "Ingrese una letra: ",'$'
			cartel3 DB "Ingrese letra de reemplazo: ",'$'
			cartel4 DB "El texto cambiado es: ",'$'
			salto DB " ",0DH,0AH,'$'
.code
main proc
			mov AX,@data
			mov DS,AX
		
			mov BX,0
			
			mov AH,9
			mov DX,offset cartel1
			int 21H
	PRI:
			mov AH,1
			int 21H
			cmp AL,'$'
			je SEGU
			mov [BX+offset texto],AL
			inc BX
			jmp PRI
	SEGU:
			mov AH,9
			mov DX,offset salto
			int 21H
			
			mov AH,9
			mov DX,offset cartel2
			int 21H
			
			mov AH,1
			int 21H
			mov CL,AL
			
			mov AH,9
			mov DX,offset salto
			int 21H
			
			mov AH,9
			mov DX,offset cartel3
			int 21H
			
			mov AH,1
			int 21H
			mov CH,AL
			
			mov BX,0
	PROG:	
			mov AL,[BX+offset texto]
			cmp AL,CL
			je REES
			cmp AL,'$'
			je TERCI
			inc BX
			jmp PROG
	REES:	
			mov [BX+offset texto],CH
			inc BX
			jmp PROG
	TERCI:
			mov AH,9
			mov DX,offset salto
			int 21H
			
			mov AH,9
			mov DX,offset cartel4
			int 21H
			
			mov AH,9
			mov DX,offset texto
			int 21H
			
			mov AX,4C00H
			int 21H
endp
end main
			