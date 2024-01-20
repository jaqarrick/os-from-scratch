; org directive tells assembler where we expect our code to be loaded
; The assembler uses this information to calculate label addresses
org 0x7C00

; bits directive tells assembler to emit 16/32/64-bit code
bits 16

main:
    ; Halt instruction - stops the processor until an interrupt occurs
    hlt

; .halt is a label
.halt:
    ; Jump to the .halt label, creating an infinite loop
    jmp .halt

; Fill the remaining space in the bootloader up to the 512-byte limit with zeros
; times 510-($-$$) calculates the number of bytes remaining and fills them with zeros
times 510-($-$$) db 0

; Boot signature (magic number) - 0xAA55 is the standard signature for a bootable sector
dw 0xAA55
