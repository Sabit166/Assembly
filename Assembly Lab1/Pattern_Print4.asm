; 1
; 1 2
; 1 2 3
; 1 2 3 4
; 1 2 3 4 5
; 1 2 3 4 5
; 1 2 3 4
; 1 2 3
; 1 2
; 1

.MODEL SMALL
.STACK 1000H
.DATA
MSG DB 'Enter a digit (1-9): $'
VAR1 DW 1
VAR2 DW 1
.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ;PRINT PROMPT
    MOV AH, 09
    LEA DX, MSG
    INT 21H

    ;INPUT A DIGIT
    MOV AH, 01
    INT 21H
    MOV AH, 0
    SUB AX, 30h
    MOV CX, AX
    MOV VAR2, AX
    MOV BX, 1

    ;NEWLINE AFTER INPUT
    MOV AH, 02
    MOV DX, 0Dh
    INT 21H
    MOV DX, 0Ah
    INT 21H

    L1: PUSH CX
        MOV CX, BX
        MOV VAR1, 49

        L2: MOV DX, VAR1
            INT 21h
            MOV DX, 20H
            INT 21h
            INC VAR1
            LOOP L2

        ;NEW LINE
        MOV DX, 0Dh
        INT 21H
        MOV DX, 0Ah
        INT 21H

        POP CX
        INC BX
        LOOP L1

    MOV CX, VAR2
    L3: PUSH CX
        MOV VAR1, 49
        L4: MOV DX, VAR1
            INT 21H
            MOV DX, 20H
            INT 21H
            INC VAR1
            LOOP L4
        ; New line
        MOV DX, 0Dh
        INT 21h
        MOV DX, 0Ah
        INT 21h
        POP CX
        LOOP L3

MAIN ENDP
END MAIN