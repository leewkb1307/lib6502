; Doing multiplication by shift and add
; -------------------------------------
;
; Let's multiply 133 by 202.
;
; 133 -> 10000101
; 202 -> 11001010
;
;    Radix bit 0  Product
; 11001010        00000000
;  1100101 0      00000000
;                 00000000 0
;   110010 1 => + 10000101 0
;                 01000010 10
;    11001 0      01000010 10
;                 00100001 010
;     1100 1 => + 10100110 010
;                 01010011 0010
;      110 0      01010011 0010
;                 00101001 10010
;       11 0      00101001 10010
;                 00010100 110010
;        1 1 => + 10011001 110010
;                 01001100 1110010
;          1 => + 11010001 1110010
;                 01101000 11110010 #

main:
    LDA    #133
    LDX    #202
    JSR    multiply
done:
    JMP    done

; zero page ram
multiplc    equ     $f0
multiplr    equ     $f1
productl    equ     $f2

; Input:
;   A - multiplicand
;   X - multiplier
;
; Output:
;   A - product high byte
;   X - product low byte
;
multiply:
    STA     multiplc
    STX     multiplr
    LDA     #0
    LDX     #8
loop:
    LSR     multiplr
    BCC     skip
    CLC
    ADC     multiplc
skip:
    ROR     A
    ROR     productl
    DEX
    BNE     loop
    LDX     productl
    RTS
