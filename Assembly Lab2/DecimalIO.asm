.MODEL SMALL
.STACK 100H
.DATA
NEWLINE DB 0AH, 0DH, '$'
DIVISOR DW 10
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV BX, 0
    MOV CX, 0
    HEXINPUT:
    MOV AH, 01H
    INT 21H
    CMP AL, 0DH
    JE NEXTSTEP
    INC CX
    SHL BX, 4
    CMP AL, '9'
    JLE DIGCOM

    CHARCOM:
    SUB AL, 'A'
    ADD AL, 10
    OR BL, AL
    JMP HEXINPUT

    DIGCOM:
    SUB AL, '0'
    OR BL, AL
    JMP HEXINPUT

    NEXTSTEP:
    MOV AH, 09H
    MOV DX, OFFSET NEWLINE
    INT 21H
    MOV AX, BX
    MOV CX, 0          
    MOV BX, 10         

    DECOUTPUT:
    MOV DX, 0       
    DIV BX             
    PUSH DX            
    INC CX             
    CMP AX, 0          
    JNE DECOUTPUT      

    DECPRINT:
    POP DX             
    ADD DL, '0'        
    MOV AH, 02H
    INT 21H
    LOOP DECPRINT

    MOV AH, 4CH        
    INT 21H
MAIN ENDP
END MAIN