.MODEL SMALL
.STACK 100H
.DATA
ENTERVALMSG DB 'ENTER VALUE OF X: $'
NUMMSG DB 'GIVEN INPUT IS A NUMBER.$'
AGAINMSG DB 'DO YOU  WANT TO GIVE ANOTHER INPUT?$'
CONMSG DB 'GIVEN INPUT IS A CONSONANT.$'  ; Fixed message
VOWMSG DB 'GIVEN INPUT IS A VOWEL.$'      ; Fixed message
INVMSG DB 'GIVEN INPUT IS INVALID.$'
NEWLINE DB 0AH, 0DH, '$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
TAKEINPUT:
    MOV AH, 09H
    LEA DX, ENTERVALMSG
    INT 21H
    
    MOV AH, 01H
    INT 21H
    MOV BL, AL  ; Store input in BL
    
    MOV AH, 09H
    LEA DX, NEWLINE
    INT 21H
    
    CMP BL, '0'
    JGE GRTEQLNUM
    JMP INV

GRTEQLNUM:
    CMP BL, '9'
    JLE VALIDNUM
    CMP BL, 'A'      ; Compare with 'A' instead of 41H
    JGE GRTEQLA
    JMP INV          ; Input between '9' and 'A' is invalid

VALIDNUM:
    MOV AH, 09H
    LEA DX, NUMMSG
    INT 21H
    LEA DX, NEWLINE
    INT 21H
    JMP CHEKCYN

GRTEQLA:
    CMP BL, 'Z'      ; Compare with 'Z' instead of 5AH
    JLE VALIDCHAR    ; Fixed typo: VALIDCHAR not VALUDCHAR
    JMP INV

VALIDCHAR:
    CMP BL, 'A'
    JE VOWEL
    CMP BL, 'E'
    JE VOWEL
    CMP BL, 'I'
    JE VOWEL
    CMP BL, 'O'
    JE VOWEL
    CMP BL, 'U'
    JE VOWEL
    
    ; It's a consonant
    MOV AH, 09H
    LEA DX, CONMSG
    INT 21H
    LEA DX, NEWLINE
    INT 21H
    JMP CHEKCYN

VOWEL:
    MOV AH, 09H
    LEA DX, VOWMSG
    INT 21H
    LEA DX, NEWLINE
    INT 21H
    JMP CHEKCYN

CHEKCYN:
    MOV AH, 09H
    LEA DX, NEWLINE
    INT 21H
    LEA DX, AGAINMSG
    INT 21H
    LEA DX, NEWLINE
    INT 21H
    MOV AH, 01H
    INT 21H
    CMP AL, 'Y'
    MOV AH, 09H
    LEA DX, NEWLINE
    INT 21H
    JE TAKEINPUT
    CMP AL, 'y'      ; Added lowercase 'y' check
    JE TAKEINPUT
    JMP ENDCODE

INV:
    MOV AH, 09H
    LEA DX, INVMSG
    INT 21H
    LEA DX, NEWLINE
    INT 21H
    JMP CHEKCYN

ENDCODE:
    MOV AH, 4CH      ; Correct exit function
    INT 21H

MAIN ENDP
END MAIN