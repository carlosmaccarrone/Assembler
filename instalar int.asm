.8086
.model tiny
.code
org 100H
start: 
			jmp main

interrupcion proc FAR
			
			cmp AH,5
			je PROG
			jmp FINPG
PROG:			
			mov AX,CX
			imul BX
			
			mov BX,DX
			mov CX,AX
			
			mov SI,BX
			shl SI,1
			jc NEGATIVO
			mov AL,0
			jmp FINPG1
NEGATIVO:		
			mov AL,1
			not BX
			not CX
			add CX,1
			jc CONCARRY
			jmp FINPG1	
CONCARRY: 	
			add BX,1
FINPG1:
			iret
FINPG:			
			jmp CS:ViejaIntXX
			
endp

ViejaIntXX      LABEL   DWORD
DespIntXX DW 0
SegIntXX  DW 0


FinResidente LABEL BYTE	

cartel1 DB "Programa Instalado exitosamente!!!",0DH, 0AH,'$'

main:
    mov AX,CS
    mov DS,AX
    mov ES,AX
	

InstalarInt:
    mov AX,3582h        
    int 21h    
         
    mov DespIntXX,BX    
    mov SegIntXX,ES

    mov AX,2582h	
    mov DX,offset interrupcion
    int 21h

MostrarCartel:
    mov AH,9
	mov DX,offset cartel1
    int 21h

DejarResidente:		
    Mov     AX,(15+offset FinResidente) 
    Shr     AX,1            
    Shr     AX,1       
    Shr     AX,1
    Shr     AX,1	
    Mov     DX,AX           
    Mov     AX,3100h    
    Int     21h         
end start


