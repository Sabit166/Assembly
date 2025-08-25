.MODEL SMALL
.STACK 100H
.DATA 
 
  msg db 'Same$',0 
  msg1 db 'Not Same$',0
  
.CODE

MAIN PROC
              
    MOV AH,01H         
    INT 21H
                           
    MOV BL,AL 
    MOV AH,01H
    INT 21H
    
    
    CMP AL,BL
    JE L 
    JMP L1
    L: 
    MOV AX,@DATA
    MOV DS,AX  
                
      MOV AH,09H
      LEA DX,msg
      int 21H 
      JMP L2      
                 
    L1:
    MOV AX,@DATA
    MOV DS,AX   
     MOV AH,09H
      LEA DX,msg1 
      INT 21H  
      JMP L2           
                 
       
    
L2:MAIN ENDP
END MAIN