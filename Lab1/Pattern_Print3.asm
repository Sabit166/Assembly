.MODEL SMALL
.STACK 100H
.DATA
MSG DB 'Enter a digit (1-9): $'   
VAR1 DW 1
.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Print prompt
    MOV AH, 09
    LEA DX, MSG
    INT 21h

    ; Input a digit
    MOV AH, 01
    INT 21h
    SUB AL, 30h       ; convert ASCII to number
    MOV CL, AL        ; store number in CL
    MOV CH, 0
    MOV BL, 1         ; outer loop counter (row number) 
    MOV BH, 0

    ; New line after input
    MOV AH, 02
    MOV DL, 0Dh
    INT 21h
    MOV DL, 0Ah
    INT 21h

L1: PUSH CX           ; save total rows

    MOV CX, BX 
    MOV VAR1, 49
    
    L2:
    MOV DX, VAR1
    INT 21H     
    INC VAR1
    LOOP L2

    ; New line
    ;MOV AH, 02
    MOV DX, 0Dh
    INT 21h
    MOV DX, 0Ah
    INT 21h

    POP CX
    INC BX
    LOOP L1

    ; Exit
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
