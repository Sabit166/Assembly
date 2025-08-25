.MODEL SMALL
.STACK 100H
.DATA
.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV AH, 01
    INT 21H
    SUB AL, '0'

    MOV BX, 0
    L1:
        SHL BX, 1
        OR BL, AL

        EXITZ;
        

    MAIN ENDP
END MAIN