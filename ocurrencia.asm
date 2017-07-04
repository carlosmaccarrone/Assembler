.8086
.model small
.stack 100H
.data
			texto1 DB 255 dup(' '),'$'
			texto2 DB 16 dup(' '),'$'
			cartel1 DB "Ingrese un texto de hasta doscientos cincuenta y cinco caracteres: ",'$'
			cartel2 DB "Ingrese un texto de hasta ocho caracteres: ",'$' 
			cartela DB "El caracter asociado al numero hexa es: ",'$'
			cartel3 DB "El valor hexa de la ocurrencia del segundo en el primero es: ",'$'
			cartel4 DB "No hubo ocurrencia",'$'
			salto DB " ",0DH,0AH,'$'

.code
main proc
			mov AX,@data
			mov DS,AX
			
			xor BX,BX
			xor DI,DI

			mov AH,9
			mov DX,offset cartel1
			int 21H
	PRI:
			mov AH,1
			int 21H
			cmp AL,'$'
			je SEGU
			mov [BX+offset texto1],AL
			inc BX
			jmp PRI
	SEGU:	
			mov AH,9
			mov DX,offset salto
			int 21H
	
			mov AH,9
			mov DX,offset cartel2
			int 21H
	TERCI:		
			mov AH,1
			int 21H
			cmp AL,'$'
			je CUATRI
			mov [DI+offset texto2],AL
			inc DI
			jmp TERCI
	CUATRI:
			mov AH,9
			mov DX,offset salto
			int 21H
			
			xor BX,BX
	SEIS:
			xor DI,DI
	SIETE:
			mov AL,[BX+DI+offset texto1]
			cmp AL,texto2[DI]
			je CINCO
			inc BX
			cmp texto1[BX],'$'
			je NOCU
			jmp SEIS
	CINCO:
			inc DI
			cmp texto2[DI],20H
			je OCU
			cmp texto1[BX+DI],'$'
			je NOCU
			jmp SIETE
			
	OCU:	
			mov AH,9
			mov DX,offset cartela
			int 21H

			mov AH,6
			mov DX,BX
			int 21H

			mov AH,9
			mov DX,offset salto
			int 21H
			
			mov AH,9
			mov DX,offset cartel3
			int 21H
				
			mov CL,4
			shl BX,CL
			shr BL,CL
			

	LETRA:
			cmp BH,9
			jle NUME
			add BH,37H
			jmp LETRA2	
	NUME:
			add BH,30H	
	LETRA2:
			cmp BL,9
			jle NUME2
			add BL,37H
			jmp IMPRE		
	NUME2:
			add BL,30H
		
	IMPRE:

			mov AH,2
			mov DL,BH
			int 21H
			
			mov AH,2
			mov DL,BL
			int 21H
			
			mov AH,2
			mov DL,'H'
			int 21H	
	
			jmp FINPG
	NOCU:				
			mov AH,9
			mov DX,offset cartel4
			int 21H			
	FINPG:		
			mov AX,4C00H
			int 21H
endp
end main