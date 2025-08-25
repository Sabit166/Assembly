.MODEL SMALL
.STACK 100H
.DATA
    B   DB  ?
    D DB ?
    AEB  DB 'A EQUAL B$'
    CED DB  'C Equal D$'
    EL DB 'ELSE CALLED$'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 01
    INT 21H
    MOV B, AL

    MOV AH, 01
    INT 21H
    MOV D, AL

    MOV AL, 21
    MOV CL, AL
    MOV AL, B


    CMP B, AL
    JZ AEQB
    CMP CL, B
    JZ CEQD
    JMP EQL

AEQB:   MOV AH, 09
        LEA DX, AEB
        INT 21H
        JMP END

CEQD:   MOV AH, 09
        LEA DX, CED
        INT 21H
        JMP END

EQL:     MOV AH, 09
        LEA DX, EL
        INT 21h

END:

MAIN ENDP
END MAIN
