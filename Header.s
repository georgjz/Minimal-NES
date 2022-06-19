; Header information needed by the emulator
; An actual NES game doesn't need this
.segment "HEADER"
    .byte "NES"
    .byte $1a
    .byte $02 ; 2 * 16KB PRG ROM
    .byte $01 ; 1 * 8KB CHR ROM
    .byte %00000001 ; mapper and mirroring
    .byte $00
    .byte $00
    .byte $00
    .byte $00
    .byte $00, $00, $00, $00, $00 ; filler bytes