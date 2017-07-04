.8086
.model small
.stack 100H
.data
			cartel1 DB"Ingrese un numero binario de dieciseis bits: ",'$'
			cartel2 DB "Ingrese otro numero binario de dieciseis bits: ",'$'
			cartel3 DB "La multiplicacion es: ",'$'
			salto DB " ",0DH,0AH,'$'
.code
main proc
			mov AX,@data
			mov DS,AX
			xor BX,BX
			
			mov AH,9
			mov DX,offset cartel1
			int 21H
			
			mov CX,10H
			call ingre
			mov SI,BX
			
			mov AH,9
			mov DX,offset salto
			int 21H
			
			mov AH,9
			mov DX,offset cartel2
			int 21H
			
			mov CX,10H
			call ingre
			mov DI,BX
			
			mov BX,SI
			mov CX,DI
			
			mov AH,5
			int 82H
			
			mov AH,9
			mov DX,offset salto
			int 21H
			
			mov AH,9
			mov DX,offset cartel3
			int 21H
		
			mov DX,BX
			mov AX,CX
			
			mov SI,DX
			mov CX,10H
			call impre
		
			mov SI,AX
			mov CX,10H
			call impre
			
		
			mov AX,4C00H
			int 21H
endp

ingre proc
	PRI:
			mov AH,1
			int 21H
			cmp AL,'0'
			je CERO
			cmp AL,'1'
			je UNO
			jmp PRI
	CERO:
			shl BX,1
			jmp SIGO
	UNO:
			shl BX,1
			add BX,1
	SIGO:
			loop PRI
			ret
endp

impre proc
			push AX
	CICLO:
			shl SI,1
			jc UNO2
			mov AH,6
			mov DL,'0'
			int 21H
			jmp SIGO2
	UNO2:
			mov AH,6
			mov DL,'1'
			int 21H
	SIGO2:
			loop CICLO
			pop AX
			ret
endp

end main