;     #           n=3, bx=0, blank=5, hash=2, blank=(((n-bx)-1)*2)+1
;   # # #         n=3, bx=1, blank=3, hash=4, hash=(bx+1)*2
; # # # # #       n=3, bx=2, blank=1, hash=6
;   # # #         N=2, BX=0, BLANK=3, HASH=4, BLANK=((BX+1)*2)+1
;     #           N=2, BX=1, BLANK=5, HASH=2, HASH=(N-BX)*2

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

    MOV AH, 09H
    LEA DX, MSG
    INT 21H

    MOV AH,01H
    INT 21H
    SUB AL, '0'
    MOV AH, 0
    MOV N, AX

    MOV AH, 02
    MOV DX, 0DH
    INT 21H
    MOV DX, 0AH
    INT 21H

    MOV CX, 0 
    
FIRST_LOOP:
    CMP CX, N
    JGE SECONDPART
    
    MOV AX, N
    SUB AX, CX
    DEC AX
    SHL AX, 1 
    INC AX
    MOV BLANK, AX
    
    MOV AX, CX
    INC AX
    SHL AX, 1
    MOV HASH, AX
    
    MOV BX, BLANK
PRINT_SPACE1:
    CMP BX, 0
    JLE PRINT_HASH1
    MOV DX, ' '
    MOV AH, 02H
    INT 21H
    DEC BX
    JMP PRINT_SPACE1

PRINT_HASH1:
    MOV BX, HASH
PRINT_HASH_LOOP1:
    DEC BX 
    CMP BX, 0
    JLE END_LINE1
    MOV DX, '#'
    MOV AH, 02H
    INT 21H
    MOV DX, ' '
    INT 21H
    ;DEC BX
    JMP PRINT_HASH_LOOP1

END_LINE1:
    MOV DX, 0AH
    INT 21H
    MOV DX, 0DH
    INT 21H
    INC CX
    JMP FIRST_LOOP

SECONDPART:
    MOV CX, 0
    MOV AX, N
    DEC AX 
    MOV N, AX

SECOND_LOOP:
    CMP CX, N
    JGE ENDPROGRAM
    
    MOV AX, CX
    INC AX
    SHL AX, 1
    INC AX
    MOV BLANK, AX
    
    MOV AX, N
    SUB AX, CX
    SHL AX, 1
    MOV HASH, AX
    
    MOV BX, BLANK
PRINT_SPACE2:
    CMP BX, 0
    JLE PRINT_HASH2
    MOV DX, ' '
    MOV AH, 02H
    INT 21H
    DEC BX
    JMP PRINT_SPACE2

PRINT_HASH2:
    MOV BX, HASH
PRINT_HASH_LOOP2:
    DEC BX
    CMP BX, 0
    JLE END_LINE2
    MOV DX, '#'
    MOV AH, 02H
    INT 21H
    MOV DX, ' '
    INT 21H
    ;DEC BX
    JMP PRINT_HASH_LOOP2

END_LINE2:
    MOV DX, 0AH
    INT 21H
    MOV DX, 0DH
    INT 21H
    
    INC CX
    JMP SECOND_LOOP

ENDPROGRAM:
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN