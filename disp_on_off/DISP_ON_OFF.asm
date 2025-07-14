;======================================================================
; Title  : MDA-8086 Output Program
; Purpose: Send string "MIST" to an I/O device via port-mapped I/O
; Author : [Sabit]
;======================================================================

CODE SEGMENT
    ASSUME CS:CODE, DS:CODE, ES:CODE, SS:CODE
    ORG 1000H             ; Start of the program

; -------------------------
; EQUATES (I/O Port Mapping)
; -------------------------
IR     EQU 00H            ; Instruction Register port
DR     EQU 04H            ; Data Register port
FLAGS  EQU 02H            ; Status Flags port

; -------------------------
; Stack Initialization
; -------------------------
    MOV AX, 0000H         ; AX = 0
    MOV SS, AX            ; Stack Segment = 0
    MOV SP, 0540H         ; Stack Pointer = 540H
    MOV DS, AX            ; Data Segment = 0
    MOV ES, AX            ; Extra Segment = 0

; -------------------------
; Device Initialization
; -------------------------
    CALL ISBUSY
    MOV AL, 01H
    OUT IR, AL

    CALL ISBUSY
    MOV AL, 0C4H
    OUT IR, AL

; -------------------------
; MAIN LOOP
; -------------------------
START:
    CALL DISPON           ; Turn display ON

    LEA SI, M1            ; Load address of string into SI

PRINT_CHAR:
    MOV AH, [SI]          ; Load current character
    CMP AH, 00H           ; End of string?
    JE  END_DISPLAY       ; If null, end display loop

    CALL CHAROUT          ; Output character
    INC SI                ; Move to next character
    JMP PRINT_CHAR        ; Repeat

; -------------------------
; Output One Character (AH → DR)
; -------------------------
CHAROUT:
    CALL ISBUSY
    MOV AL, AH
    OUT DR, AL
    RET

; -------------------------
; Wait Until Device Is Not Busy
; -------------------------
ISBUSY:
    IN AL, FLAGS
    AND AL, 10000000B     ; Check bit 7 (busy flag)
    JNZ ISBUSY
    RET

; -------------------------
; Turn Display ON
; -------------------------
DISPON:
    CALL ISBUSY
    MOV AL, 0FH
    OUT IR, AL
    RET

; -------------------------
; Turn Display OFF
; -------------------------
DISPOFF:
    CALL ISBUSY
    MOV AL, 08H
    OUT IR, AL
    RET

; -------------------------
; End of Display - Turn OFF, Delay, and Loop Again
; -------------------------
END_DISPLAY:
    CALL DISPOFF          ; Turn off display
    MOV CX, 3000H         ; Delay loop
DELAY:
    LOOP DELAY
    JMP START             ; Repeat

; -------------------------
; DATA SECTION
; -------------------------
M1 DB 'MIST', 00H         ; Null-terminated string

CODE ENDS
END
