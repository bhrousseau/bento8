********************************************************************************
* Boot loader FD - Benoit Rousseau 06/06/2021
* ------------------------------------------------------------------------------
* 
* Description
* -----------
* Affiche un Damier en 160x200
*
********************************************************************************
(main)BOOT.ASM        
        org   $6200

InitVideo
        orcc  #$50                     ; desactive les interruptions
	lds   #$9FFF                   ; positionnement pile systeme
        lda   #$7B                     ; passage en mode 160x200x16c
        sta   $E7DC       
        
        ldb   $6081                    ; $6081 est l'image "lisible" de $E7E7
        orb   #$10                     ; positionne le bit d4 a 1
        stb   $6081                    ; maintient une image coherente de $E7E7
        stb   $E7E7                    ; bit d4 a 1 pour pages donnees en mode registre
	ldb   #$00
        stb   $E7E5                    ; page 2 visible dans l'espace donnees
	
	ldx   #$0707                   ; alt. 2 black (0) and 2 white pixels (7)
        jsr   ClearInterlacedEvenDataMemory
	ldx   #$7070                   ; alt. 2 white (0) and 2 black pixels (7)
        jsr   ClearInterlacedOddDataMemory	
     
        bra   *                        ; infinite loop
	
	    rmb   79,0
	
pal_buffer                             
        fcb   $42                      ; B
        fcb   $41                      ; A
        fcb   $53                      ; S
        fcb   $49                      ; I
        fcb   $43                      ; C
        fcb   $32                      ; 2
								       
pal_idx                                
        fcb   $00                      ;
        fcb   $00                      ;
        
*-------------------------------------------------------------------------------
* A partir de ce point le code doit commencer a l'adresse $6280
*-------------------------------------------------------------------------------

ClearInterlacedEvenDataMemory
        ldb   #$18
        stb   CIDM_a_start+3
        stb   CIDM_b_start+3
        ldb   #0
        stb   CIDM_a_end+3
        stb   CIDM_b_end+3        
        bra   ClearInterlacedDataMemory

ClearInterlacedOddDataMemory
        ldb   #$40
        stb   CIDM_a_start+3
        stb   CIDM_b_start+3        
        ldb   #$28
        stb   CIDM_a_end+3
        stb   CIDM_b_end+3        
        
ClearInterlacedDataMemory 
        pshs  u,dp
        sts   CIDM_end+2
        
CIDM_a_start
        lds   #$DF40                   ; (dynamic)
        leau  ,x
        leay  ,x
        tfr   x,d
        tfr   a,dp
CIDM_a
        pshs  u,y,x,dp,b,a
        pshs  u,y,x,dp,b,a
        pshs  u,y,x,dp,b,a
        pshs  u,y,x,dp,b,a        
        pshs  u,y
CIDM_a_end         
        cmps  #$C000
        leas  -40,s                                
        bne   CIDM_a  
      
CIDM_b_start
        lds   #$BF40                   ; (dynamic)
CIDM_b
        pshs  u,y,x,dp,b,a
        pshs  u,y,x,dp,b,a
        pshs  u,y,x,dp,b,a
        pshs  u,y,x,dp,b,a        
        pshs  u,y
CIDM_b_end         
        cmps  #$A000
        leas  -40,s                                
        bne   CIDM_b          
             
CIDM_end        
        lds   #$0000        
        puls  dp,u,pc