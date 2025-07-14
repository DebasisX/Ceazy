; bootloader.asm using book 16 bit real mode
[BITS 16]
[ORG 0x7C00]          ; BIOS loads the bootloader at this address

start:
    ; Set video mode to 80x25 color text mode (optional)
    mov ah, 0x0E       ; BIOS teletype function

    mov si, message

.print:
    lodsb              ; Load byte at [SI] into AL, increment SI
    or al, al          ; Check for null terminator
    jz halt
    int 0x10           ; Print character in AL
    jmp .print

halt:
    cli                ; Clearing stupid interrupts
    hlt                ; Halt CPU

message db "Hello from Bootloader!", 0

times 510-($-$$) db 0 ; Padding up to 510 bytes
dw 0xAA55             ; Boot signature (must be last 2 bytes)