CODE SEGMENT
        ASSUME CS:CODE, DS:CODE, ES:CODE, SS:CODE

         ;equates
         PA equ 19h
         PB equ 1Bh
         PC equ 1Dh
         CR equ 1Fh
         MOV AL,10000000b
         OUT CR,AL

         MOV AL, 11000000B ; ONE IN SEVEN SEGMENT
         MOV PA, AL ;PRINT IN SEVEN SEGMENT

         MOV AL, 00000001B ; BLUE LED
         MOV PB, AL ;

CODE ENDS
END