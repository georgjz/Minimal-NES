; This is the main code
.segment "MAIN"
Reset:
    sei        ; ignore IRQs
    cld        ; disable decimal mode
    ldx #$40
    stx $4017  ; disable APU frame IRQ
    ldx #$ff
    txs        ; Set up stack
    inx        ; now X = 0
    stx $2000  ; disable NMI
    stx $2001  ; disable rendering
    stx $4010  ; disable DMC IRQs

    ; The vblank flag is in an unknown state after reset
    bit $2002

    ; First of two waits for vertical blank to make sure that the
    ; PPU has stabilized
Vblankwait1:
    bit $2002
    bpl Vblankwait1

    txa
ClrMem:
    sta $000,x
    sta $100,x
    sta $200,x
    sta $300,x
    sta $400,x
    sta $500,x
    sta $600,x
    sta $700,x
    inx
    bne ClrMem

; Wait for PPU stabilized
Vblankwait2:
    bit $2002
    bpl Vblankwait2
    jmp MainLoop

    ; other code

MainLoop:
    ; main loop code
    jmp MainLoop

; Vblank interrupt
NMI:
    ; Vblank code
    rti


; This are the addresses of the NMI and Reset routines
; We want to place it at the end of the ROM
.segment "VECTORS"
    .word NMI
    .word Reset


; Graphics data, loaded into the segment CHARS
.segment "CHARS"
    .incbin "hellomario.chr"
