.8086
.model small
.stack 100H
.data
			cartel1 DB "Ingrese un numero binario de ocho bits: ",'$'
			cartel2 DB "Ingrese una cifra Hexa: ",'$'
			cartel3	DB "Ingrese un numero Hexa de dos cifras: ",'$'
			cartel4	DB "El numero en binario es: ",'$'
			cartel5 DB "Ingrese un numero binario de dieciseis bits: ",'$'
			cartel6 DB "El numero en hexa es: ",'$'
			
			
			peticion DB "Elija una opcion",'$'
			pet1 DB "1-Ingresar numero binario",'$'
			pet2 DB "2-Ingresar hexa de una cifra",'$'
			pet3 DB "3-Ingresar hexa de dos cifras",'$'
			pet4 DB "4-Imprimir numero en binario",'$'
			pet5 DB "5-Ingresar binario 16bits",'$'
			pet6 DB "6-Imprimir Hexa",'$'
			pet7 DB "7-Salir",'$'
			
			salto DB " ",0DH,0AH,'$'
.code
main proc
			mov AX,@data
			mov DS,AX
BUCLE:		
			mov AH,9
			mov DX,offset salto
			int 21H		
			mov AH,9
			mov DX,offset peticion
			int 21H
			mov AH,9
			mov DX,offset salto
			int 21H
			mov AH,9
			mov DX,offset pet1
			int 21H
			mov AH,9
			mov DX,offset salto
			int 21H			
			mov AH,9
			mov DX,offset pet2
			int 21H
			mov AH,9
			mov DX,offset salto
			int 21H			
			mov AH,9
			mov DX,offset pet3
			int 21H
			mov AH,9
			mov DX,offset salto
			int 21H			
			mov AH,9
			mov DX,offset pet4
			int 21H
			mov AH,9
			mov DX,offset salto
			int 21H			
			mov AH,9
			mov DX,offset pet5
			int 21H
			mov AH,9
			mov DX,offset salto
			int 21H		
			mov AH,9
			mov DX,offset pet6
			int 21H
			mov AH,9
			mov DX,offset salto
			int 21H			
			mov AH,9
			mov DX,offset pet7
			int 21H
			mov AH,9
			mov DX,offset salto
			int 21H				
			
			
			
			mov AH,1
			int 21H
		
			cmp AL,'1'
			je FBIN
			cmp AL,'2'
			je FHEX
			cmp AL,'3'
			je FHEX2
			cmp AL,'4'
			je FIMP
			cmp AL,'5'
			je	INGBIN
			cmp AL,'6'
			je IMPHEXA
			cmp AL,'7'
			je FBUCLE
			jmp BUCLE			
FBIN:
			call binario
			mov AH,9
			mov DX,offset salto
			int 21H
			
			jmp BUCLE
FHEX:
			mov AH,9
			mov DX,offset salto
			int 21H

			mov AH,9
			mov DX,offset cartel2
			int 21H		
			
			call hexa
			mov BL,AL
			mov AH,9
			mov DX,offset salto
			int 21H
			
			jmp BUCLE
FHEX2:
			call hexa2
			
			mov AH,9
			mov DX,offset salto
			int 21H
			
			jmp BUCLE
FIMP:
			push BX
			call imprebin
			pop BX
		
			mov AH,9
			mov DX,offset salto
			int 21H
			
			jmp BUCLE
INGBIN:
			mov AH,9
			mov DX,offset salto
			int 21H		
			
			call ingrexad
			jmp BUCLE
IMPHEXA:
			mov AH,9
			mov DX,offset salto
			int 21H
			
			call imprehexa
			jmp BUCLE		
FBUCLE:		
			
			mov AX,4C00H
			int 21H
endp

binario proc	
			mov AH,9
			mov DX,offset salto
			int 21H
			
			mov AH,9
			mov DX,offset cartel1
			int 21H

			mov CX,8
	PRI:
			mov AH,1
			int 21H
			cmp AL,'0'
			je CERO
			cmp AL,'1'
			je UNO
			jmp PRI
	CERO:
			shl BL,1
			jmp SIGO
	UNO:
			shl BL,1
			add BL,1
	SIGO:
			loop PRI
			
			ret
endp

hexa proc			
	CICLO1:
			mov AH,1
			int 21H
			cmp AL,'0'
			jl CICLO1
			cmp AL,'F'
			jg CICLO1
			cmp AL,'9'
			jle NUMERO
			cmp AL,'A'
			jge LETRA
			jmp CICLO1
	NUMERO:
			sub AL,30H			
			jmp SIGO1
	LETRA:
			sub AL,37H			
	SIGO1:	
			
			ret
endp
	
hexa2 proc
			mov AH,9
			mov DX,offset salto
			int 21H

			mov AH,9
			mov DX,offset cartel3
			int 21H		
			
			call hexa
			
			mov BH,AL
			
			call hexa
			
			mov BL,AL
			
			mov CL,4
			shl BL,CL
			shr BX,CL
			
			ret
endp

imprebin proc

			push BP	
			mov BP,SP
			mov BX,[BP+4]
		
			mov AH,9
			mov DX,offset salto
			int 21H
			
			mov AH,9
			mov DX,offset cartel4
			int 21H
			
			mov CX,8		
	CICLO2:
			shl BL,1
			jc UNO2
	CERO2:
			mov AH,6
			mov DL,'0'
			int 21H
			jmp SIGA2
	UNO2:
			mov AH,6
			mov DL,'1'
			int 21H
	SIGA2:
			loop CICLO2
			pop BP
			
			ret
endp

ingrexad proc
			
			mov AH,9
			mov DX,offset cartel5
			int 21H

			mov CX,10H
	PRIH:
			mov AH,1
			int 21H
			cmp AL,'0'
			je CEROH
			cmp AL,'1'
			je UNOH
			jmp PRIH
	CEROH:
			shl BX,1
			jmp SIGOH
	UNOH:
			shl BX,1
			add BX,1
	SIGOH:
			loop PRIH
			ret
endp



imprehexa proc

			mov AH,9
			mov DX,offset cartel6
			int 21H
			
			mov CL,BH
			shl CX,1
			shl CX,1
			shl CX,1
			shl CX,1
			shr CL,1
			shr CL,1
			shr CL,1
			shr CL,1
			
			shl BX,1
			shl BX,1
			shl BX,1
			shl BX,1
			shr BL,1
			shr BL,1
			shr BL,1
			shr BL,1
			
			and BH,0FH
			and BL,0FH
			and CH,0FH
			and CL,0FH

	LETRAH:								
			cmp CH,9					
			jle NUMEH				
			add CH,37H					
			jmp LETRA2H					
	NUMEH:								
			add CH,30H					
	LETRA2H:								
			cmp CL,9					
			jle NUME2H					
			add CL,37H					
			jmp LETRA3H					
	NUME2H:								
			add CL,30H					
	LETRA3H:								
			cmp BH,9					
			jle NUME3H				
			add BH,37H					
			jmp LETRA4H					
	NUME3H:							
			add BH,30H				
	LETRA4H:								
			cmp BL,9				
			jle NUME4H					
			add BL,37H					
			jmp IMPRE2H					
	NUME4H:								
			add BL,30H					
	IMPRE2H:																	
								
			mov AH,2					
			mov DL,CH					
			int 21H						
										
			mov AH,2				
			mov DL,CL					
			int 21H					
										
			mov AH,2				
			mov DL,BH					
			int 21H						
										
			mov AH,2					
			mov DL,BL					
			int 21H						
										
			mov AH,2					
			mov DL,'H'					
			int 21H		
			ret
endp

end main
