include(`commons.m4')main            proc near
                push    ebp
                mov     ebp, esp
                push    edi
                push    esi
                push    ebx
                and     esp, 0FFFFFFF0h
                sub     esp, 40h
                mov     dword ptr [esp], 0 ; timer
                lea     esi, [esp+14h]
                call    _time
                lea     edi, [esp+38h]  ; struct end
                mov     [esp+4], esi    ; tp
                mov     [esp+10h], eax
                lea     eax, [esp+10h]
                mov     [esp], eax      ; timer
                call    _localtime_r
                lea     esi, [esi+0]	; NOP
; _EN(``ESI here is the pointer to structure in local stack. EDI is the pointer to structure end.'')_RU(``ESI здесь это указатель на структуру в локальном стеке. EDI это указатель на конец структуры.'')
loc_8048408:
                xor     ebx, ebx        ; j=0

loc_804840A:
                movzx   eax, byte ptr [esi+ebx]	; _EN(`load byte')_RU(`загрузить байт')
                add     ebx, 1          ; j=j+1
                mov     dword ptr [esp+4], offset a0x02x ; "0x%02X "
                mov     dword ptr [esp], 1
                mov     [esp+8], eax	; _EN(`pass loaded byte to')_RU(`передать загруженный байт в') printf()
                call    ___printf_chk
                cmp     ebx, 4
                jnz     short loc_804840A
; _EN(`print carriage return character')_RU(`вывести символ перевода каретки') (CR)
                mov     dword ptr [esp], 0Ah ; c
                add     esi, 4
                call    _putchar
                cmp     esi, edi        ; _EN(`meet struct end')_RU(`достигли конца структуры')?
                jnz     short loc_8048408 ; j=0
                lea     esp, [ebp-0Ch]
                pop     ebx
                pop     esi
                pop     edi
                pop     ebp
                retn
main            endp
