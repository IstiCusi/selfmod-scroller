/*
    DONE AS PROOF OF ABILITY IN 2016 BY STEPHAN STRAUSS
    Most scrollers are restriced to most 256 bytes, this one not ; it uses self-modifying code.
*/

//.break

.const shiftRegister    =   $D016
.const keyboardRegister =   $DC01
.const raster           =   $D012
.const clearScreen 	=   $E544


BasicUpstart2(start)

            *=$0810

start:

        // Disable interrupts and clear screen

        sei
        jsr clearScreen

        // Setup indirect pointer

        lda #<text  // LowByte
        sta $BB

        lda #>text  // HighByte
        sta $BC

        // Initialization of copy loop

        ldy #39  // DEC [0,39] ; length=40 (char width)

copyLoop:

        lda ($BB),y
        sta erange, y
        dey             // decreased AFTER sta
        bpl copyLoop    // ... so should be stopped when negative

redoShift:

        ldx #$C7
        stx shiftRegister

checkkeys:

        lda keyboardRegister
        cmp #$FF
        bne endit

        ldx #$12
wait:

        dex
        bne wait

shiftPixels:      // to be zero (outside of view)

        lda raster
        bne shiftPixels  // jump back as long raster is not zero

        ldx shiftRegister
        dex
        stx shiftRegister
        cpx #$BF

        bne wait

        // Initialization of print loop

        ldy #$00

printLoop:

        lda load:text,y
        cmp #$00            // brk 082e if .A==$00
        beq initialize

        sta store:[$0400+23*40],y
        iny
        cpy #40             // iny before, therefore against 40 and not 39
        bne     printLoop

        // Initalization of the new starting address of the printloop

        clc

        lda load    // Low byte in big-endian (reflection code)
        adc #$01
        sta load

        lda load+1  // High byte in big-endian (reflection code)
        adc #$00
        sta load+1

        ldy #$00

        beq redoShift

        rts     // Never reached (infinite loop)

initialize:

        // Reinitialization when end of text is reached (NULL-termination)

        lda #<text
        sta load
        lda #>text
        sta load+1
        ldy #$00
        beq  printLoop // unconditional fast jump (trick!)

endit:
        rts

        .align $100

brange:
        .text ">>>"

text:
        .encoding "screencode_upper"
        .import text "humanrights.txt"

erange:
        .fill 40, 'X'
        .byte $00
        .text "<<<"

