; LAB 2   LCD INTERFACE
; LCD Code 2 BLINKING MESSAGE


;ASSEMBLER DIRECTIVES
CODE SEGMENT
ASSUME CS:CODE, DS:CODE, SS:CODE, ES:CODE

	; EQUATES
		IR	EQU   00 ;can be 00h. port address for LCD instruction register.
		FLAGS	EQU   02 ;can be 02h. port address for LCD flag register.
		DR	EQU   04 ;can be 00h. port address for LCD data register.

	;INITIALIZE/SET UP
		ORG 1000H
		MOV AX, 0
                MOV DS, AX    ; clearing the Data segment
                MOV SS, AX    ; clearing the Stack Segment
                MOV SP, 540H  ; tells where the stack top will be


	; CLEAR DISPLAY
		CALL ISBUSY
		MOV AL, 1
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
		
		
         ;  PRINT MESSAGE 2
                MOV SI, OFFSET M2
         D:     MOV AH, [SI]
                CMP AH, 0
                JE P
                CALL CHAROUT
                INC SI
                JMP D
                
         P:     CALL WAITT
                CALL DISPOFF
                CALL WAITT
                CALL DISPON
                JMP P

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
                
        ; DISPLAY ON FUNCTION
                  ; FLAGS 0000 1DCB.  IF D IS 1, THEN DISPLAY ON ELSE OFF. IF C IS 1, THEN CURSOR WILL BE VISIBLE ELSE CURSOR WILL NOT SHOW. IF B IS 1, THEN CURSOR WILL BE BLINKING ELSE IT WILL NOT BLINK.
                  DISPON: CALL ISBUSY
                          MOV AL,0FH  ;D=1,C=1,B=1
                          OUT IR,AL
                          RET
        ; DISPLAY OFF FUNCTION

                  DISPOFF: CALL ISBUSY
                          MOV AL,08H
                          OUT IR,AL   ;D=0,C=0,B=0
                          RET
                          
        ;WAITING FUNCTION
                 WAITT: MOV CX,1111111111111111B
                 L:LOOP L
                 RET


        ; VARIABLE DECLARATION
                M1 DB 'MIST', 0
                M2 DB 'CSE DEPT', 0


FINISH: HLT
CODE ENDS