;=======================================================================
; Program: Display "MIST" using I/O Ports (8086 Assembly)
; Target : 8086 with simulated MDA or custom device using I/O ports
; Author : [Sabit]
;=======================================================================
CODE SEGMENT
    ASSUME CS:CODE, DS:CODE, ES:CODE, SS:CODE  
    ORG 1000H  

    ; Define device I/O port addresses
    IR      EQU 00H       ; Instruction Register port
    DR      EQU 04H       ; Data Register port
    Flags   EQU 02H       ; Status/Flags port (bit 7 = busy flag)

    START:
        ;----------------------------
        ; Step 1: Initialize Stack
        ;----------------------------
        MOV AX, 0            ; Clear AX
        MOV SS, AX           ; Stack Segment = 0
        MOV SP, 0540H        ; Stack Pointer = 540H (for stack usage)

        ;----------------------------
        ; Step 2: Initialize Data Segment
        ;----------------------------
        MOV AX, CS           ; Set DS = CS (since string is in same segment)
        MOV DS, AX
        MOV ES, AX           ; Set ES if needed

        ;----------------------------
        ; Step 3: Send Initialization Commands to Device
        ;----------------------------
        CALL ISBUSY          ; Wait until device is not busy
        MOV AL, 01H          ; First command
        OUT IR, AL           ; Send to Instruction Register

        CALL ISBUSY
        MOV AL, 0C4H         ; Second command (specific to your device)
        OUT IR, AL

        ;----------------------------
        ; Step 4: Output String "MIST"
        ;----------------------------
        LEA SI, M1           ; Load address of string into SI

    PRINT_LOOP:
        MOV AH, [SI]         ; Load current character into AH
        CMP AH, 0            ; Check for null terminator
        JE END_PROGRAM       ; If null, end
        CALL CHAROUT         ; Output character
        INC SI               ; Move to next character
        JMP PRINT_LOOP       ; Repeat

    ;----------------------------
    ; Subroutine: ISBUSY
    ; Purpose: Wait until device is ready (bit 7 clear)
    ;----------------------------
    ISBUSY:
        IN AL, Flags         ; Read status flags from device
        AND AL, 10000000B    ; Mask for bit 7 (busy flag)
        JNZ ISBUSY           ; If busy, keep checking
        RET

    ;----------------------------
    ; Subroutine: CHAROUT
    ; Purpose: Output character in AH to Data Register
    ;----------------------------
    CHAROUT:
        CALL ISBUSY          ; Wait until device is ready
        MOV AL, AH           ; Move character to AL
        OUT DR, AL           ; Output character to Data Register
        RET

    ;----------------------------
    ; Data: Null-terminated string to display
    ;----------------------------
    M1 DB 'MIST', 0

    ;----------------------------
    ; Program End
    ;----------------------------
    END_PROGRAM:
        JMP $                ; Infinite loop to end program cleanly

    CODE ENDS  
    END START
    ;=======================================================================
    ; End of program