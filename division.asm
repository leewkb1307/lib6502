; Doing division by shift and subtract
; ------------------------------------
;
; Let's divide 237 by 10.
;
; 237 -> 11101101
;  10 -> 00001010
;
;     Divisor           Dividend                     Quotient
; #0: 00001010          11101101
; #1: 00001010        1 1101101  => 1 < 1010      -> 0
; #2: 00001010       11 101101   => 11 < 1010     -> 0
; #3: 00001010      111 01101    => 111 < 1010    -> 0
; #4: 00001010     1110 1101     => 1110 >= 1010  -> 1
;                   100          <- 1110 - 1010
; #5: 00001010     1001 101      => 1001 < 1010   -> 0
; #6: 00001010    10011 01       => 10011 >= 1010 -> 1
;                  1001          <- 10011 - 1010
; #7: 00001010    10010 1        => 10010 >= 1010 -> 1
;                  1000          <- 10010 - 1010
; #8: 00001010    10001          => 10001 >= 1010 -> 1
;                   111          <- 10001 - 1010
;              Remainder
;
; Quotient = 00010111 -> 23
; Remainder = 111 -> 7

main:
    LDA    #237
    LDX    #10
    JSR    divide
done:
    JMP    done

; zero page ram
dividend    equ     $f0
divisor     equ     $f1
quotient    equ     $f2

; Input:
;   A - dividend
;   X - divisor
;
; Output:
;   A - remainder
;   X - quotient
;
divide:
    STA     dividend
    STX     divisor
    LDA     #0
    LDX     #8
loop:
    ROL     dividend
    ROL     A
    CMP     divisor
    BCC     skip
    SBC     divisor
skip:
    ROL     quotient
    DEX
    BNE     loop
    LDX     quotient
    RTS
