;     #
;   # # #
; # # # # #
;   # # #
;     #

.MODEL SMALL
.STACK 100H
.DATA
MSG DB 'ENTER N: $'
BLANK DW 1
HASH DW 1
N DW 1
.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ;PRINT PROMPT
    MOV AH, 09H
    LEA DX, MSG
    INT 21h

    ;INPUT DIGIT
    MOV AH, 01
    INT 21H
    MOV AH, 0
    SUB AX, 30h
    MOV N, AX

    ;NEW LINE AFTER INPUT
    MOV AH, 02
    MOV DX, 0DH
    INT 21H
    MOV DX, 0Ah
    INT 21H
    
    MOV CX, N
    MOV BLANK, CX
    MOV HASH, 1
    DEC BLANK
    SHL BLANK, 1 
    LOOP1: PUSH CX
           MOV CX, BLANK
           JZ HSH
           BLANKLOOP: MOV DX, 20H
                      INT 21H
                      LOOP BLANKLOOP
           SUB BLANK, 2
           HSH:
           MOV CX, HASH
           HASHLOOP: MOV DX, 23H
                     INT 21H
                     MOV DX, 20H
                     INT 21H
                     LOOP HASHLOOP
           ADD HASH, 02
           ; New line
           MOV AH, 02
           MOV DX, 0Dh
           INT 21h
           MOV DX, 0Ah
           INT 21h
           POP CX
           LOOP LOOP1

    MOV CX, N
    MOV HASH, CX
    DEC CX
    MOV BLANK, 02
    LOOP2: PUSH CX
           MOV CX, BLANK
           BLANKLOOP2: MOV DX, 20H
                       INT 21H
                       LOOP BLANKLOOP2
           
           ADD BLANK, 02
           MOV CX, HASH
           HASHLOOP2: MOV DX, 23H
                      INT 21h
                      MOV DX, 20H
                      INT 21H
                      LOOP HASHLOOP2
           SUB HASH, 02
           ; New line
           MOV AH, 02
           MOV DX, 0Dh
           INT 21h
           MOV DX, 0Ah
           INT 21h
           POP CX
           LOOP LOOP2

MAIN ENDP
END MAIN
           
