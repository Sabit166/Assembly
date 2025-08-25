.MODEL SMALL
.STACK 100H

.DATA
    N DB 4
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    MOV CX, 1  ;I=1;I<N;I++
    LS: CMP CX, N
    JGE LE
    ;
    ;
    INC CX
    JMP LS
    LE:

    ;; JUST SIMILAR TO FOR LOOP
