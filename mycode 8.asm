TITLE CALCULATOR PROGRAM 
.MODEL SMALL 
.DATA 
MAIN_MENU DB 10,"Calculater","$" 
A DB 10,"'A' For ADDITION","$" 
S DB 10,"'S' For SUBTRACTION","$" 
M DB 10,"'M' For MULTIPLICATION","$" 
D DB 10,"'D' For DIVISION","$"
E DB 10,"'E' For EXIT","$" 
R DB 10,"'R' For RETURN to Main Menu","$"  
C DB 10,"Enter Your CHOICE: ",'$' 
ADD1 DB 10,"FOR ADDITION",'$' 
SUB1 DB 10,"FOR SUBTRACTION",'$' 
MUL1 DB 10,"FOR MULTIPLICATION",'$' 
DIV1 DB 10,"FOR DIVISION",'$' 
NUM1 DB 10,"Enter First Number: ",'$' 
NUM2 DB 10,"Enter Second Number: ",'$'
ANS DB 10,"ANSWER ",'$' 
CONTINUE DB 10,"DO YOU WANT TO CONTINUE: ",'$'
EX DB 10,"YOUR WAY IS GREEN,In the safety of God :)",'$'  
OP1 DB ? 
OP2 DB ? 

.CODE  
main proc far 
    .STARTUP
    START:
    MOV AH,09H 
    MOV DX, OFFSET MAIN_MENU 
    INT 21H 
    
    MOV AH,09H 
    MOV DX, OFFSET A 
    INT 21H 
    
    MOV AH,09H 
    MOV DX, OFFSET S
    INT 21H 
    
    MOV AH,09H 
    MOV DX, OFFSET M 
    INT 21H 
    
    MOV AH,09H 
    MOV DX, OFFSET D 
    INT 21H 
    
    MOV AH,09H 
    MOV DX, OFFSET E 
    INT 21H 
    
    MOV AH,09H 
    MOV DX, OFFSET R 
    INT 21H 
    
    MOV AH,09H 
    MOV DX, OFFSET C 
    INT 21H 
    ;READ CHAR FROM USER
    MOV AH,01H 
    INT 21H  
    ;CHECK 
    CMP AL,'A' 
    JE sum 
    CMP AL,'S' 
    JE SUBT 
    CMP AL,'M' 
    JE mult 
    CMP AL,'D' 
    JE divi 
    CMP AL,'R' 
    JE START 
    CMP AL,'E' 
    JE EXIT 
sum: 
    CALL ADDITION 
    
SUBT:
    CALL SUBTRACTION
 
mult:
    CALL MULTIPLICATION 
 
divi:
    CALL DIVISION 

EXIT:
    CALL EXITING
    
.EXIT 
main endp
;---------------------------------------
ADDITION proc near 
    ;PRINT FOR ADDITION
    MOV DX,OFFSET ADD1  
    MOV AH,09H  
    INT 21H 
    ;PRINT ENTER FIRST OPERAND 
    MOV AH,09H 
    MOV DX,OFFSET NUM1 
    INT 21H 
    ;READ NUM 1
    MOV AH,01H 
    INT 21H 
    MOV OP1,AL 
    ;PRINT ENTER SECOND OPERAND 
    MOV AH,09H 
    MOV DX,OFFSET NUM2 
    INT 21H 
    ;READ NUM 2
    MOV AH,01H 
    INT 21H 
    
    ;PRINT THE ANSWER
    MOV AH,09H 
    MOV DX, OFFSET ANS 
    INT 21H 
    
  
    ADD AL,OP1 ; RESULT IN AL 
    sub AL,48 ;RANGE 0:9
    MOV DL,AL  
    MOV AH,02H
    INT 21H 
    
    MOV AH,09H 
    MOV DX,OFFSET CONTINUE 
    INT 21H 
    
    MOV AH,01H ;READ CHAR FROM USER
    INT 21H 
     
    CMP AL,'E' ;CHEAK
    JE EXIT 
    CMP AL,'R' 
    JMP START
    RET
ADDITION endp
;-----------------------------
SUBTRACTION proc near
    MOV AH,09H 
    MOV DX,OFFSET SUB1 
    INT 21H 
    ;FIRST OPERAND 
    MOV AH,09H 
    MOV DX,OFFSET NUM1 
    INT 21H 
    
    MOV AH,01H 
    INT 21H 
    MOV OP1,AL 
    ;SECOND OPERAND 
    MOV AH,09H 
    MOV DX,OFFSET NUM2 
    INT 21H
                
    MOV AH,01H 
    INT 21H 
    MOV OP2,AL 
    MOV AL,OP1 
    MOV AH,09H 
    MOV DX, OFFSET ANS 
    INT 21H 
    ;*
    SUB AL,OP2
    ADD AL,48
    MOV DL,AL 
    ; PRINT RESULT 
    MOV AH,02H 
    INT 21H 
    
    ;FOR CONTINUE 
    MOV AH,09H 
    MOV DX,OFFSET CONTINUE 
    INT 21H
    
    MOV AH,01H ; READ CHAR
    INT 21H 

    CMP AL,'E' 
    JE EXT 
    CMP AL,'R' 
    JMP START
    RET
SUBTRACTION endp
;-----------------------------------
MULTIPLICATION proc near
    MOV AH,09H 
    MOV DX,OFFSET MUL1 
    INT 21H 
    ;FIRST OPERAND 
    MOV AH,09H 
    MOV DX,OFFSET NUM1 
    INT 21H 
    
    MOV AH,01H 
    INT 21H
    ;**
    SUB AL,30H 
    MOV OP1,AL 
    
    ;SECOND OPERAND 
    MOV AH,09H 
    MOV DX,OFFSET NUM2 
    INT 21H
    
    MOV AH,01H 
    INT 21H 
    
    SUB AL,30H
    
    MOV AH,09H ;PRINT THE ANSWER
    MOV DX, OFFSET ANS 
    INT 21H
    ;*
    MUL OP1 
    AAM ; ASCII Adjust after Multiplication(AAM):
    ADD AH,30H ;CONVERT NUMBER MN HEXA LE DESIMAL
    ADD AL,30H ;CONVERT NUMBER MN HEXA LE DESIMAL
    MOV BX,AX 
    ;PRINT THE RESELT
    MOV DL,BH 
    MOV AH,02H 
    INT 21H
    MOV DL,BL
    MOV AH,02H
    INT 21H 
   
    ;FOR CONTINUE 
    MOV AH,09H 
    MOV DX,OFFSET CONTINUE 
    INT 21H 
    MOV AH,01H 
    INT 21H 
 
    CMP AL,'E' 
    JE EXT 
    CMP AL,'R' 
    JMP START
    EXT:
        CALL EXITING
    RET
MULTIPLICATION endp
;------------------------------------
DIVISION proc near
    MOV AH,09H 
    MOV DX,OFFSET DIV1 
    INT 21H 
    ;FIRST OPERAND 
    MOV AH,09H 
    MOV DX,OFFSET NUM1 
    INT 21H 
    MOV AH,01H 
    INT 21H
    SUB AL,30H 
    MOV OP1,AL 
    ;SECOND OPERAND 
    MOV AH,09H 
    MOV DX,OFFSET NUM2 
    INT 21H 
    MOV AH,01H 
    INT 21H 
    SUB AL,30H
    MOV OP2,AL 
    
    MOV AH,09H 
    MOV DX, OFFSET ANS 
    INT 21H 
    ;**
    MOV CL,OP1 
    MOV CH,00
    MOV AX,CX
    DIV OP2 
    MOV AH, 00
    AAD ;ASCII Adjust before Division(AAD)
    ADD AH,30H
    ADD AL,30H
    MOV BX,AX
    MOV AH,02H
    MOV DL,BH
    INT 21H
    MOV AH,02H
    MOV DL,BL
    INT 21H
    
    ;FOR CONTINUE 
    MOV AH,09H 
    MOV DX,OFFSET CONTINUE 
    INT 21H 
    MOV AH,01H 
    INT 21H 

    CMP AL,'E' 
    JE EXT 
    CMP AL,'R' 
    JMP START  
    RET 
DIVISION endp
;----------------------------------
EXITING PROC NEAR
    MOV AH,09H 
    MOV DX,OFFSET EX 
    INT 21H 
    MOV AH,4CH 
    INT 21H  
    RET
EXITING ENDP
end main



