HUIDA SEGMENT BYTE PUBLIC 'CODE'

PUBLIC _AccHuida

ASSUME CS: HUIDA

_AccHuida PROC FAR

    PUSH BP
    MOV BP, SP
    push bx dx si ds

    ; te voy a enseñar a usar el sable laser mi joven padawan

    mov ax, [bp+42] ; LA FUEEEEERZA
    mov bx, 100
    mul bx

    lds si, [bp+6]
    mov [si], ax
    mov [si+2], dx

    lds si, [bp+10]
    mov [si], ax
    mov [si+2], dx

    lds si, [bp+14]
    mov [si], ax
    mov [si+2], dx

    cmp ax, 0
    je final
    mov ax, 1

    final:
        pop ds si dx bx
        pop bp
        ret         

_AccHuida ENDP

HUIDA ENDS ; FIN DEL SEGMENTO DE CODIGO
END ; FIN DE pract3a.asm
