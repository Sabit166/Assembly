CODE SEGMENT
        ASSUME CS:CODE, DS:CODE, ES:CODE, SS:CODE
        ORG 1000H
        
        ;EQUATE
        PA EQU 18H
        PB EQU 1AH
        PC EQU 1CH
        CR EQU 1EH
        
        MOV AL, 10000000B
        OUT CR, AL
        
        MOV AL, 0FFH
        OUT PA, AL
        OUT PB, AL
        OUT PC, AL
        
        PATT DB 0FEH, 7EH, 0E7H
        
        ABAR:
        MOV SI, OFFSET PATT
        MOV AL, [SI]
        OUT PA, AL
        INC SI
        
        MOV AL, [SI]
        OUT PB, AL
        INC SI
        
        MOV AL, [SI]
        OUT PA, AL
        OUT PB, AL
        JMP ABAR
        
        CODE ENDS
        END