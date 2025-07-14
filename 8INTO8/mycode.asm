CODE SEGMENT
        ASSUME CS:CODE, DS:CODE, ES:CODE, SS:CODE
        ORG 1000H           ; Set the starting address for the code segment
        
        ;---------------------------------------------------------
        ; EQU directives to define port addresses (typically 8255 ports)
        ;---------------------------------------------------------
        PA EQU 18H          ; Port A address
        PB EQU 1AH          ; Port B address
        PC EQU 1CH          ; Port C address (not used directly here)
        CR EQU 1EH          ; Control Register address

        ;---------------------------------------------------------
        ; Initialize 8255 Control Register: Set control word
        ; 10000000b => Mode 0, all ports (A, B, C) as output
        ;---------------------------------------------------------
        MOV AL, 10000000B   ; Control word to set all ports as output in Mode 0
        OUT CR, AL          ; Send control word to control register

        ;---------------------------------------------------------
        ; Initialize all ports (A, B, C) with 0FFH => all HIGH
        ;---------------------------------------------------------
        MOV AL, 0FFH
        OUT PA, AL          ; Write 0xFF to Port A
        OUT PB, AL          ; Write 0xFF to Port B
        OUT PC, AL          ; Write 0xFF to Port C

        ;---------------------------------------------------------
        ; Data pattern to be output to ports (stored in memory)
        ;---------------------------------------------------------
        PATT DB 0FEH, 7EH, 0E7H  ; Pattern values (3 bytes total)

ABAR:
        ;---------------------------------------------------------
        ; Load address of PATT into SI to access data
        ;---------------------------------------------------------
        MOV SI, OFFSET PATT      ; Load pointer to pattern array

        ; First pattern -> Port A
        MOV AL, [SI]             ; Load 0FEH
        OUT PA, AL               ; Send to Port A
        INC SI                   ; Move to next pattern

        ; Second pattern -> Port B
        MOV AL, [SI]             ; Load 7EH
        OUT PB, AL               ; Send to Port B
        INC SI                   ; Move to next pattern

        ; Third pattern -> Both Port A and B
        MOV AL, [SI]             ; Load 0E7H
        OUT PA, AL               ; Send to Port A
        OUT PB, AL               ; Send to Port B again

        JMP ABAR                 ; Infinite loop: repeat output

CODE ENDS
END
