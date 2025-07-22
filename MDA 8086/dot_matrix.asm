CODE SEGMENT
        ASSUME CS:CODE, DS:CODE, ES:CODE, SS:CODE

         ;equates
         PA equ 18h
         PB equ 1Ah
         PC equ 1Ch
         CR equ 1Eh
         MOV AL,10000000b
         OUT CR,AL

         MOV AL,0FFH
         OUT PA,AL
         OUT PB,AL

         MOV AL,00000100b
         OUT PC,AL
         MOV AL,11111011b
         OUT PB,AL


CODE ENDS
END
