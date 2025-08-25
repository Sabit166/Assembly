                     .MODEL SMALL
.STACK 100H
.DATA 
    msg1 db 'Hello$',0
    msg2 db 'Bye$',0
    msg3 db  'See you$',0
.CODE

MAIN PROC
    mov ax,@data
    Mov ds,ax 
    MOV AH,01H         
    INT 21H
    SUB AL,030h  
    MOV BX,0
    
  
   
  L1:
    
    SHL BX,1
    OR BL,AL    
    MOV AH,01H
    INT 21H
   
    CMP AL,0DH
    JE EXIT 
    
     SUB AL,030H
     JMP L1 
    EXIT:  
    MOV AH,02H
    MOV DX,0AH
    INT 21H
    MOV DX,0DH
    INT 21H
       
    MOV CX,16D  
    L2:
    ROL BX,1
    JC ONE
    JNC ZERO 
    NEXT: LOOP L2
    JMP EXITTTT
 ZERO:
  MOV AH,02H
  MOV DX,'0'
  INT 21H 
  JMP NEXT
  ONE:
  MOV AH,02H
  MOV DX,'1'
  INT 21H 
  JMP NEXT
       
    
  
    
    
   
   

             
            
            
            
            
    
EXITTTT:MAIN ENDP
END MAIN