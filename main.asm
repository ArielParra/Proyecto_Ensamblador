.model small

.stack 100h

.data
include mac.inc
include song.inc

;variables
int16_delay DW 0;ms
str_string0 DB "1. piano, 2. caja musical, 3. salir: ",'$';
str_string1 DB "presiona numeros y letras para sonido y esc para salir",'$';
str_string2 DB "1. Mario, 2. Zelda SOT, 3.Fur Elise, 4. Despacito, 5. salir: ",'$';

;jump / branch  tables
jumpTable_menu    DW et_default,et_piano,et_jukebox,et_salir;
jumpTable_jukebox DW case_default,case_song_1,case_song_2,case_song_3,case_song_4,case_salir;
jumpTable_numbers DW c_0,c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8,c_9,c_default;
jumpTable_letters DW a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,default;

;note constants
note_C3       equ 9121; Do 
note_Csharp3  equ 8609; Do sostenido
note_D3       equ 8126; Re
note_Dsharp3  equ 7670; Re sostenido
note_E3       equ 7239; Mi
note_F3       equ 6833; Fa
note_Fsharp3  equ 6449; Fa sostenido
note_G3       equ 6087; Sol
note_Gsharp3  equ 5746; Sol sostenido
note_A3       equ 5423; La
note_Asharp3  equ 5119; La sostenido
note_B3       equ 4831; Si
note_C4       equ 4560; Do
note_Csharp4  equ 4304; Do sostenido
note_D4       equ 4063; Re
note_Dsharp4  equ 3834; Re sostenido
note_E4       equ 3619; Mi
note_F4       equ 3416; Fa
note_Fsharp4  equ 3224; Fa sostenido
note_G4       equ 3043; Sol
note_Gsharp4  equ 2873; Sol sostenido
note_A4       equ 2711; La
note_Asharp4  equ 2559; La sostenido
note_B4       equ 2415; Si
note_C5       equ 2280; Do
note_Csharp5  equ 2152; Do sostenido
note_D5       equ 2031; Re 
note_Dsharp5  equ 1917; Re sostenido
note_E5       equ 1809; Mi
note_F5       equ 1708; Fa 
note_Fsharp5  equ 1612; Fa sostenido
note_G5       equ 1521; Sol
note_Gsharp5  equ 1436; Sol sostenido
note_A5       equ 1355; La
note_Asharp5  equ 1279; La sostenido
note_B5       equ 1207; Si
note_C6       equ 1140; Do


.code
MOV AX,@DATA
MOV DS,AX

main PROC
    print str_string0;1. piano, 2. caja musical, 3. salir:
    while0:
        getch
        XOR AH,AH
        SUB AL,'0';to number
        CMP AX,3
        JLE et_switch_validado
        MOV AX,0;default

        et_switch_validado:
            SHL AX,1
            LEA BX,jumpTable_menu
            ADD BX,AX;indice ya validado
            JMP [BX]

        switch_menu:
            et_piano:
                CALL piano
            et_default:
                ;print inside loop
                endl
                print str_string0;1. piano, 2. caja musical, 3. salir:
                jmp et_break0;
            et_jukebox:
                CALL jukebox
                jmp et_default;
            et_salir:
                exit
            et_break0:

    JMP while0
    eliwh0:

main ENDP

piano PROC
    endl
    print str_string1;presiona numeros y letras para sonido y esc para salir
    MOV int16_delay,800;ms 
    while1:
        
        kbhit 
        JZ while1
          
        getch
        XOR AH, AH
        
        CMP AL,1Bh;'esc' 
        JNE et_continue
        JMP eliwh1

        et_continue:

        CMP AL, '9'
        JG et_validarLetras

        et_validarNumeros:
            SUB AL, '0'
            CMP AX,10
            JL et_numerosValidados
            MOV AX,10;default

            et_numerosValidados:
                SHL AX,1
                LEA BX,jumpTable_numbers
                ADD BX,AX;indice ya validado
                JMP [BX]
            
        et_validarLetras:
            SUB AL, 'a'         
            ;validar rango
            CMP AX,26; 'z' - 'a'
            JL et_letrasValidadas
            MOV AX,26;default
        
            et_letrasValidadas:
                SHL AX,1
                LEA BX,jumpTable_Letters
                ADD BX,AX
                JMP [BX]
        
        switch_numbers:
            c_1:
                MOV BX, note_Csharp3
                CALL beep_proc
                JMP break1
            c_2:
                MOV BX, note_Dsharp3
                CALL beep_proc
                JMP break1
            c_3:
                JMP break1
            c_4:
                MOV BX, note_Fsharp3
                CALL beep_proc
                JMP break1
            c_5:
                MOV BX, note_Gsharp3
                CALL beep_proc
                JMP break1
            c_6:
                MOV BX, note_Asharp3
                CALL beep_proc
                JMP break1
            c_7:
            c_8:
            c_9:
            c_0:
            c_default:
                JMP break1
            
            break1:
                jmp break2; jumps to the switch_letters break2;

        switch_letters:
            q:
                MOV BX, note_C3
                CALL beep_proc
                JMP break2
            w:
                MOV BX, note_D3
                CALL beep_proc
                JMP break2
            e:
                MOV BX, note_E3
                CALL beep_proc
                JMP break2
            r:
                MOV BX, note_F3
                CALL beep_proc
                JMP break2
            t:
                MOV BX, note_G3
                CALL beep_proc
                JMP break2
            y:
                MOV BX, note_A3
                CALL beep_proc
                JMP break2
            u:
                MOV BX, note_B3
                CALL beep_proc
                JMP break2
            i:
            o:
            p:
                JMP break2
            a:
                MOV BX, note_Csharp4
                CALL beep_proc
                JMP break2
            s:
                MOV BX, note_Dsharp4
                CALL beep_proc
                JMP break2
            d:
                JMP break2
            f:
                MOV BX, note_Fsharp4
                CALL beep_proc
                JMP break2
            g:
                MOV BX, note_Gsharp4
                CALL beep_proc
                JMP break2
            h:
                MOV BX, note_Asharp4
                CALL beep_proc
                JMP break2
            j:
            k:
            l:
                JMP break2
            z:
                MOV BX, note_C4
                CALL beep_proc
                JMP break2
            x:
                MOV BX, note_D4
                CALL beep_proc
                JMP break2
            c:
                MOV BX, note_E4
                CALL beep_proc
                JMP break2
            v:
                MOV BX, note_F4
                CALL beep_proc
                JMP break2
            b:
                MOV BX, note_G4
                CALL beep_proc
                JMP break2
            n:
                MOV BX, note_A4
                CALL beep_proc
                JMP break2
            m:
                MOV BX, note_B4
                CALL beep_proc
                JMP break2
            default:
        break2:

    JMP while1   
    eliwh1:
RET
piano ENDP

beep_proc PROC
    beep_on
    sleep int16_delay
    beep_off
RET
beep_proc ENDP

jukebox PROC
    endl
    print str_string2;1. Mario, 2. Zelda SOT, 3.Fur Elise, 4. Despacito, 5. salir: 
    while2:
        getch
        XOR AH,AH
        SUB AL,'0'
        CMP AX,5
        JLE et_salto_validado
        MOV AX,0;default

        et_salto_validado:
            SHL AX,1
            LEA BX,jumpTable_jukebox
            ADD BX,AX;indice ya validado
            JMP [BX]

        switch_jukebox:
            case_song_1:
                song_1
                JMP while2
            case_song_2:
                song_2
                JMP case_default
            case_default:
                JMP while2
            case_song_3:
                song_3
                JMP case_default
            case_song_4:
                song_4
                JMP case_default
            case_salir:
                JMP eliwh2
    eliwh2:
RET
jukebox ENDP


END;code segment