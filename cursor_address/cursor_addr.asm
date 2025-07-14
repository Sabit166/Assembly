;=======================================================================
; Title: Device Communication using MDA-style Port I/O on 8086
; Author: [Your Name]
; Purpose: Demonstrates output to device using port-mapped I/O
;=======================================================================

CODE SEGMENT
    ASSUME CS:CODE, DS:CODE, ES:CODE, SS:CODE

    ORG 1000H                ; Load code at memory location 1000H

; ----------------------------
; Define I/O port addresses
; ----------------------------
IR      EQU 00H              ; Instruction Register port
DR      EQU 04H              ; Data Register port
Flags   EQU 02H              ; Status Flags port

; ----------------------------
; Setup stack and segments
; ----------------------------
    MOV AX, 0000H            ; Clear AX
    MOV SS, AX               ; Set Stack Segment to 0
    MOV SP, 0540H            ; Set Stack Pointer to 540H
    MOV DS, AX               ; Set Data Segment to 0
    MOV ES, AX               ; Set Extra Segment to 0

; ----------------------------
; Device Communication Sequence
; ----------------------------

    CALL ISBUSY              ; Wait until device is ready
    MOV AL, 01H              ; First command to send
    OUT IR, AL               ; Send to Instruction Register

    CALL ISBUSY              ; Wait until ready again
    MOV AL, 0C4H             ; Second command
    OUT IR, AL               ; Send to Instruction Register

; ----------------------------
; End of program (infinite loop or HALT here)
; ----------------------------
    JMP $                   ; Infinite loop to end cleanly
                            ; Replace with HLT if allowed

; ----------------------------
; ISBUSY Subroutine
; Waits while device is busy (bit 7 of FLAGS is set)
; ----------------------------
ISBUSY:
    IN AL, Flags             ; Read device status flags
    AND AL, 10000000B        ; Mask bit 7 (busy flag)
    JNZ ISBUSY               ; If busy (bit 7 set), wait
    RET                      ; Else, return

CODE ENDS
END
