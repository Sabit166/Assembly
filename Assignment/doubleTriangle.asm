; #     #   N=4, BX=0, HASH1=1, SPACE=5, HASH2=1, HASH1=HASH2=BX+1
; ##   ##   N=4, BX=1, HASH1=2, SPACE=3, HASH2=2, SPACE=((N-BX)*2)-3
; ### ###   N=4, BX=2, HASH1=3, SPACE=1, HASH2=3
; #######   N=4, HASH=(2*N)-1
; ### ###   N=4, BX=0, HASH1=3,SPACE=1, HASH2=4
; ##   ##   N=4, BX=1, HASH1=2, SPACE=3, HASH2=3, HASH1=HASH2=N-BX-1
; #     #   N=4, BX=2, HASH1=1, SPACE=5, HASH2=2, SPACE=((BX+1)*2)-1

; Diamond pattern program in 8086 Assembly

.MODEL SMALL
.STACK 100H
.DATA
N DW 1
HASH DW 1
SPACE DW 1

MSG DB 'ENTER THE VALUE OF N: $'
PRINTHASH DB '#$'
PRINTSPACE DB ' $'
NEWLINE DB 0AH,0DH,'$'

.CODE

MAIN PROC
    ; Initialize DS
    MOV AX, @DATA
    MOV DS, AX

    ; Ask for input
    MOV AH, 09H
    LEA DX, MSG
    INT 21H

    ; Read single-digit N
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV AH, 0
    MOV N, AX

    ; -------------------
    ; First half (upper part)
    ; -------------------
    MOV CX, 0
OUTERLOOP1:
    CMP CX, N
    JGE ALLHASH             ; if CX >= N, jump to middle line

    ; HASH = CX + 1
    MOV AX, CX
    INC AX
    MOV HASH, AX

    ; SPACE = ((N - CX) * 2) - 3
    MOV AX, N
    SUB AX, CX
    SHL AX, 1
    SUB AX, 3
    MOV SPACE, AX

    ; Print HASH1
    MOV BX, HASH
HASH1PART1:
    CMP BX, 0
    JLE SPACEPART1
    MOV AH, 09H
    LEA DX, PRINTHASH
    INT 21H
    DEC BX
    JMP HASH1PART1

SPACEPART1:
    MOV BX, SPACE
SPACEPART1PRINT:
    CMP BX, 0
    JLE HASH2PART1
    MOV AH, 09H
    LEA DX, PRINTSPACE
    INT 21H
    DEC BX
    JMP SPACEPART1PRINT

HASH2PART1:
    MOV BX, HASH
HASH2PART1PRINT:
    CMP BX, 0
    JLE PART1ENDLINE
    MOV AH, 09H
    LEA DX, PRINTHASH
    INT 21H
    DEC BX
    JMP HASH2PART1PRINT

PART1ENDLINE:
    MOV AH, 09H
    LEA DX, NEWLINE
    INT 21H

    INC CX
    JMP OUTERLOOP1

    ; -------------------
    ; Middle full hash line
    ; -------------------
ALLHASH:
    MOV AX, N
    SHL AX, 1
    DEC AX
    MOV BX, AX

PRINTALLHASH:
    CMP BX, 0
    JLE ENDFIRSTPART
    MOV AH, 09H
    LEA DX, PRINTHASH
    INT 21H
    DEC BX
    JMP PRINTALLHASH

ENDFIRSTPART:
    MOV AH, 09H
    LEA DX, NEWLINE
    INT 21H

    ; -------------------
    ; Second half (lower part)
    ; -------------------
    MOV CX, 0
OUTERLOOP2:
    CMP CX, N
    JGE ENDPROGRAM

    ; HASH = N - CX - 1
    MOV AX, N
    SUB AX, CX
    DEC AX
    MOV HASH, AX

    ; SPACE = ((CX + 1) * 2) - 1
    MOV AX, CX
    INC AX
    SHL AX, 1
    DEC AX
    MOV SPACE, AX

    ; Print HASH1
    MOV BX, HASH
HASH1PART2:
    CMP BX, 0
    JLE SPACEPART2
    MOV AH, 09H
    LEA DX, PRINTHASH
    INT 21H
    DEC BX
    JMP HASH1PART2

SPACEPART2:
    MOV BX, SPACE
SPACEPART2PRINT:
    CMP BX, 0
    JLE HASH2PART2
    MOV AH, 09H
    LEA DX, PRINTSPACE
    INT 21H
    DEC BX
    JMP SPACEPART2PRINT

HASH2PART2:
    MOV BX, HASH
HASH2PART2PRINT:
    CMP BX, 0
    JLE PART2ENDLINE
    MOV AH, 09H
    LEA DX, PRINTHASH
    INT 21H
    DEC BX
    JMP HASH2PART2PRINT

PART2ENDLINE:
    MOV AH, 09H
    LEA DX, NEWLINE
    INT 21H

    INC CX
    JMP OUTERLOOP2

    ; -------------------
    ; Exit program
    ; -------------------
ENDPROGRAM:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
