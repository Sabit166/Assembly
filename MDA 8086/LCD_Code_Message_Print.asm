; LAB 2   LCD INTERFACE
; LCD Code 1 PRINTING MESSAGE


;ASSEMBLER DIRECTIVES
CODE SEGMENT
ASSUME CS:CODE, DS:CODE, SS:CODE, ES:CODE

	; EQUATES
		IR	EQU   00H ;can be 00h. port address for LCD instruction register.
		FLAGS	EQU   02H ;can be 02h. port address for LCD flag register.
		DR	EQU   04H ;can be 00h. port address for LCD data register.

	;INITIALIZE/SET UP
		ORG 1000H
		MOV AX, 0
                MOV DS, AX    ; clearing the Data segment
                MOV SS, AX    ; clearing the Stack Segment
                MOV SP, 540H  ; tells where the stack top will be


	; CLEAR DISPLAY
		CALL ISBUSY
		MOV AL, 1B
		OUT IR, AL    ; SENDING 1b to LCD IR port tells the LCD to clear it.
		
		
        ; SET CURSOR POSITION
                CALL ISBUSY
		MOV AL, 089h  ; 08xH is the first row and xth column of LCD
		OUT IR, AL    ;0CxH is the second row and xth column of LCD
		
        ; PRINT MESSAGE 1
                MOV SI, OFFSET M1
        C:      MOV AH, [SI]
                CMP AH, 0
                JE F
                CALL CHAROUT
                INC SI
                JMP C
                
         ; SET NEW CURSOR POSITION
         F:     CALL ISBUSY
		MOV AL, 0C7h  ; 08xH is the first row and xth column of LCD
		OUT IR, AL    ;0CxH is the second row and xth column of LCD
		
		
        ; PRINT MESSAGE 2
                MOV SI, OFFSET M2
         D:     MOV AH, [SI]
                CMP AH, 0
                JE FINISH
                CALL CHAROUT
                INC SI
                JMP D
                
     ;;;ALL SORTS OF FUNCTION CALLS AND VARIABLE DECLARATIONS SHOULD BE PUT AT THE END OF THE CODE;;;
     ;;;AND IN NO WAY SHOULD THE PROGRAM CONTROL PASS TO THIS CODE. WHICH IS WHY WE USED A FINISH LABEL TO BYPASS THE BELOW CODES;;;
     
        ; BUSY FUNCTION
	        ISBUSY: IN AL, FLAGS      ;checks whether the LCD is busy or free
		        AND AL, 10000000B ;FLAG REGISTER'S 8TH BIT IS 1 IF BUSY, ELSE 0 IF IDLE
		        JNZ ISBUSY        ; KEEP CALLING THIS FUNCTION UNTIL THE LCD GETS IDLE
                RET

        ; CHARACTER PRINT FUNCTION
                CHAROUT: CALL ISBUSY
                         MOV AL, AH
                         OUT DR, AL
                RET

        ; VARIABLE DECLARATION
                M1 DB 'MIST', 0
                M2 DB 'CSE DEPT', 0
        
        
FINISH: HLT
CODE ENDS
END