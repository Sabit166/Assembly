                     .MODEL SMALL
.STACK 100H
.DATA 
    msg1 db 'Hello$',0
    msg2 db 'Bye$',0
    msg3 db  'See you$',0
.CODE

MAIN PROC
    MOV AH,01H         
    INT 21H
    SUB AL,030h 
    
    CMP AL,05d
    JGE L1
    JL L5
    
    L6:CMP AL,08d
    JGE L3
    
    
    
    L1:
    CMP AL,07d
    JLE L2
    JG L6
    
    
    
    L2:
    MOV AX,@DATA
    MOV DS,AX      
    MOV AH,09H
    LEA DX,MSG1  
    INT 21H 
    jmp exit
    
    
L3: 
CMP AL,0Ah
JLE L4       

L4:
MOV AX,@DATA
      MOV DS,AX 
      
      
      MOV AH,09H
      LEA DX,MSG2  
      INT 21H 
      jmp exit
      
      
L5:
MOV AX,@DATA
      MOV DS,AX 
      
      
      MOV AH,09H
      LEA DX,MSG3  
      INT 21H 
      jmp exit

             
            
            
            
            
    
exit:MAIN ENDP
END MAIN