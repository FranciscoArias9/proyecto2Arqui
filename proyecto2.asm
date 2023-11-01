
.MODEL SMALL
.STACK 500H

.DATA     

include MACROS.MAC

; LINES T1, T2, T3 AND T4 ARE USED TO BUILD THE TIC - TAC - TOE LOGO
T1 DB  4,  4, 4,  4,  4, 32,  4, 32,  4,  4,  4,  4, 32, 32, 32,  4,  4,  4, 4,  4, 32, 32,  4,  4, 32, 32,  4, 4,  4,  4,  32, 32, 32,   4,  4, 4,  4,  4,  32, 32,  4,   4, 32, 32, 4, 4, 4, 4, '$'
T2 DB 32, 32, 4, 32, 32, 32,  4, 32,  4, 32, 32, 32, 32, 32, 32, 32, 32, 4, 32, 32, 32,  4, 32, 32,  4, 32,  4, 32, 32, 32, 32, 32, 32 , 32, 32, 4, 32, 32,  32,  4, 32,  32,  4, 32, 4,'$'
T3 DB 32, 32, 4, 32, 32, 32,  4, 32,  4, 32, 32, 32, 32, 32, 32, 32, 32, 4, 32, 32, 32,  4,  4,  4,  4, 32,  4, 32, 32, 32, 32, 32, 32 , 32, 32, 4, 32, 32,  32,  4, 32,  32,  4, 32, 4, 4, 4, 4,'$' 
T4 DB 32, 32, 4, 32, 32, 32,  4, 32,  4,  4,  4,  4, 32,  4, 32, 32, 32, 4, 32, 32, 32,  4, 32, 32,  4, 32,  4,  4,  4,  4, 32,  4, 32 , 32, 32, 4, 32, 32,  32, 32,  4,   4, 32, 32, 4, 4, 4, 4,'$'
;--------------------------------------------------------------------

 
TAGLINE DB  'Proyecto 2 - Francisco Arias, Victor Coto$' ; DEVELOPER NAME 


; ----------------- IMPORTANT STRINGS USED THROUGHOUT THE GAME -----------------

PAK DB 'Presione cualquier tecla para continuar...$'


; GAME RULES
R DB 'Reglas del juego:$' 
R1 DB '1. Los jugadores jugaran por turnos.$'
R2 DB '2. El jugador 1 iniciara el juego.$'
R3 DB '3. El jugador 1 usara la "X" y el jugador 2 usara el "O".$'
R4 DB '4. El tablero esta dividido en numero.$'
R5 DB '5. Digite el numero de casilla que desea marcar.$'
R6 DB '6. Se gana al marcar 3 casillas diagonales, verticales o .$'   

R7 DB 'Buena suerte $'
 
 
; CELL MARK FOR PLAYERS 
PC1 DB ' (X)$'
PC2 DB ' (O)$' 

; BOARD LINES -------
L1 DB '   |   |   $'
L2 DB '-----------$'
N1 DB ' | $'
; -------------------

; CELL NUMBERS ------
C1 DB '1$' 
C2 DB '2$'
C3 DB '3$'
C4 DB '4$'
C5 DB '5$'
C6 DB '6$'
C7 DB '7$'
C8 DB '8$'
C9 DB '9$'
; -------------------

; PLAYER NO. , MOVES AND CHECK FLAGS FOR IF THE GAME IS WON OR DRAWN
PLAYER DB 50, '$' 
MOVES DB 0
DONE DB 0
DR DB 0 

; INPUT SECTION PROMTS -------------------------
INP DB 32, ':: Digite no. de casilla. : $'
TKN DB 'Casilla usada, elija otra. Presione cualquier tecla...$' 

; CURRENT MARK (X/O) ---------------------------
CUR DB 88

; FINAL MESSAGES -------------------------------
W1 DB 'El jugador $'
W2 DB ' gana el juego!$'
DRW DB 'Empate!$'

; TRY AGAIN PROMPT MESSAGES -----------------------------
TRA DB 'Desea jugar otra vez? (y/n): $'
WI DB  32, 32, 32, 'Entrada invalidad. Press any key...   $' 

; THIS LINE IS USED TO OVERWIRTE A LINE TO CLEAN THE AREA
EMP DB '                                        $'  

;--------------------------------------------------------  
                                                            
;;;;;;;;;; 


      
      
   
   

;;;;;;;;,,                                                     
                                                            

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX 
    
; --------- MOSTRAR EL TITULO DEL JUEGO ---------    
    TITLESCREEN_MACRO

; ----------- MOSTRAR LAS REGLAS DEL JUEGO --------------                                                                                            
    RULES_MACRO           
 ; ---------- INICIALIZAR ---------------------
    INIT:   
    InitializeVariables
    JMP PLRCHANGE                
; ------------ VICTORIA ------------------------
    VICTORY:
    VICTORY_MACRO
    JMP TRYAGAIN         
; ------------ EMPATE ------------  
    DRAW:
    DRAW_VICTORY   
    JMP TRYAGAIN                      
; ------------ REVISAR SI LA COMBINACION ES GANADORA -----------

    CHECK:   ; (EXISTEN 8 POSIBLES COMBINACIONES GANADORAS)    
    CHECK_MACRO
     
; ------------ JUGADOR ----------        
    PLRCHANGE:
    PLRCHANGE_MACRO  ; Using the PLRCHANGE_MACRO
; ------------- TABLERO ----------   
    BOARD:
    BOARD_MACRO
        
; ------------ ENTRADA --------------
    INPUT:
    INPUT_MACRO    
                                            

; ----------- JUGAR DE NUEVO -----------

    TRYAGAIN:
    TRYAGAIN_MACRO
    JMP TRYAGAIN ; PROMPT THE TRY AGAIN     
    



    EXIT:
    MOV AH, 4CH
    INT 21H 
    MAIN ENDP
END MAIN
