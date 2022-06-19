@REM First, compile all code
ca65 --cpu 6502 -o Header.obj Header.s
ca65 --cpu 6502 -o Main.obj Main.s

@REM Second, link all object files to run in an emulator
ld65 -C EmulatorFile.cfg Header.obj Main.obj -o Demo.nes

@REM Third, generate files that can be used by an EEPROM burner, we don't link the
@REM header object file because we don't need it
ld65 -C ROMFiles.cfg Main.obj
