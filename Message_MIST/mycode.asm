; 8086 Assembly Code to Display "MIST" Using I/O Ports

ASSUME CS:CODE, DS:CODE, ES:CODE, SS:CODE  
ORG 1000H  

IR      EQU 00H       ; Instruction Register port
DR      EQU 04H       ; Data Register port
Flags   EQU 02H       ; Status/Flags port

CODE SEGMENT

    ; Stack Initialization
    MOV AX, 0
    MOV DX, AX
    MOV SS, AX
    MOV SP, 540H

    ; Send initialization commands to device
    CALL ISBUSY
    MOV AL, 1
    OUT IR, AL

    CALL ISBUSY
    MOV AL, 0C4H
    OUT IR, AL

    ; Load string address
    MOV SI, OFFSET M1

R:  
    MOV AH, [SI]       ; Load character from string into AH
    CMP AH, 0          ; Check for null terminator
    JE E               ; If null, end
    CALL CHAROUT       ; Output character
    INC SI             ; Move to next character
    JMP R              ; Repeat

; Subroutine to check if device is busy
ISBUSY:  
    IN AL, Flags
    AND AL, 10000000b  ; Check D7 (busy flag)
    JNZ ISBUSY         ; Loop if still busy
    RET

; Subroutine to output character in AH to device
CHAROUT:
    CALL ISBUSY
    MOV AL, AH
    OUT DR, AL
    RET

; Data Segment
M1 DB 'MIST', 0        ; Null-terminated string

E:  
    ; Program ends here
CODE ENDS  
END
