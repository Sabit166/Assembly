.MODEL SMALL
.STACK 100H
.DATA
MSG DB 'Enter a digit (1-9): $'
.CODE

MAIN PROC
    ; input a digit
    MOV AH, 01
    INT 21h
    SUB AL, 30h     ; convert ASCII to number
    MOV CL, AL      ; store count
    MOV CH, 0
    MOV BX, 1       ; outer loop counter 
    MOV AH, 02
    MOV DL, 0DH 
    INT 21H

L1: PUSH CX
    MOV CX, BX      ; inner loop
L2: ;MOV AH, 02
    MOV DL, '*'
    INT 21h
    LOOP L2

    ; new line
    ;MOV AH, 02
    MOV DL, 0Dh
    INT 21h
    MOV DL, 0Ah
    INT 21h

    POP CX
    INC BX
    LOOP L1

    ;MOV AH, 4Ch
    ;INT 21h
MAIN ENDP
END MAIN
