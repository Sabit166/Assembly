.MODEL SMALL
.STACK 100H
.DATA
.CODE

MAIN PROC
    ; Input a digit
    MOV AH, 01
    INT 21h
    SUB AL, 30h       ; convert ASCII to number
    MOV CL, AL        ; store number in CL
    MOV CH, 0
    MOV BL, 1         ; outer loop counter (row number)

    ; New line after input
    MOV AH, 02
    MOV DL, 0Dh
    INT 21h
    MOV DL, 0Ah
    INT 21h

L1: PUSH CX           ; save total rows

    ; Print leading spaces
    MOV CL, AL
    SUB CL, BL        ; spaces = total - current row
L2: CMP CL, 0
    JE PRINT_STARS
    MOV AH, 02
    MOV DL, ' '
    INT 21h
    DEC CL
    JMP L2

PRINT_STARS:
    ; Calculate stars = 2*BL - 1
    MOV AL, BL
    MOV AH, 0
    SHL AL, 1         ; AL = 2*BL
    SUB AL, 1
    MOV CL, AL

L3: ;MOV AH, 02
    MOV DL, '*'
    INT 21h
    LOOP L3

    ; New line
    MOV AH, 02
    MOV DL, 0Dh
    INT 21h
    MOV DL, 0Ah
    INT 21h

    POP CX
    INC BL
    LOOP L1

    ; Exit
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
