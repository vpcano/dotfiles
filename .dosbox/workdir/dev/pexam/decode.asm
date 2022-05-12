DECODE SEGMENT BYTE PUBLIC 'CODE'

PUBLIC _Decode

ASSUME CS: DECODE

_Decode PROC FAR

    PUSH BP
    MOV BP, SP

    push ds es si di ax bx cx dx

    lds si, [bp+6]   ;encrypted
    les di, [bp+10]  ;dencrypted
    mov bx, [bp+14]  ; M=26-N

    mov cx, 26

    sumar_char: 
        mov ah, 0
        mov al, [si]
        cmp ax, 0
        je final
        cmp ax, ' '
        je espacio
        sub ax, 'a'
        add ax, bx
        mov dx, 0
        div cx
        add dx, 'a'
        mov es:[di], dl
        inc si
        inc di
        jmp sumar_char

    espacio:
        mov es:[di], ' '
        inc si
        inc di
        jmp sumar_char

    final:
        mov byte ptr es:[di], 0
        pop dx cx bx ax di si es ds
        pop bp
        ret 

_Decode ENDP

DECODE ENDS ; FIN DEL SEGMENTO DE CODIGO
END ; FIN DE decode.asm
