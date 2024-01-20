; org directive tells assembler where we expect our code to be loaded
; The assembler uses this information to calculate label addresses
org 0x7C00
; bits directive tells assembler to emit 16/32/64-bit code
bits 16


%define ENDL 0x0D, 0x0A


start:
    jmp main



; Prints a string to the screen
; Params:
;   - ds:si points to string
;
puts:
    ; save registers we will modify
    push si
    push ax
    push bx

.loop:
    lodsb               ; loads next character in al
    or al, al           ; verify if next character is null?
    jz .done

    mov ah, 0x0E        ; call bios interrupt
    mov bh, 0           ; set page number to 0
    int 0x10

    jmp .loop

.done:
    pop bx
    pop ax
    pop si    
    ret
    

main:
    ; setup data segments
    ; Load value of 0 into 16-bit, general-purpose AX register
    mov ax, 0           ; can't set ds/es directly
    ; Set data segment register to the value in AX, common practice for bootloaders
    mov ds, ax
    ; Set extra segment register to 0 / AX value
    mov es, ax
    
    ; setup stack
    mov ss, ax
    mov sp, 0x7C00      ; stack grows downwards from where we are loaded in memory

    ; print hello world message
    mov si, msg_hello
    call puts
    ; Halt instruction - stops the processor until an interrupt occurs
    hlt

.halt:
    jmp .halt



msg_hello: db 'Hello world!', ENDL, 0

; Fill the remaining space in the bootloader up to the 512-byte limit with zeros
; times 510-($-$$) calculates the number of bytes remaining and fills them with zeros
times 510-($-$$) db 0
; Boot signature (magic number) - 0xAA55 is the standard signature for a bootable sector
dw 0AA55h