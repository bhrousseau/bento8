********************************************************************************
* Thomson TO8 - Fondu Noir                                                     *
********************************************************************************
* Auteur  : Benoit Rousseau                                                    *
* Date    : 18/06/2020                                                         *
* Licence : GNU General Public License                                         *
********************************************************************************
(main)MAIN.ASM
	ORG $6300

********************************************************************************  
* Debut du programme
********************************************************************************
DEBUT
	orcc #$50	* desactive les interruptions	
	
********************************************************************************  
* Initialisation de la palette en noir
********************************************************************************

	ldd #$0000
SETBLACK
	sta $E7DB	* determine l'indice de couleur
	stb $E7DA	* set de la couleur Vert et Rouge
	stb $E7DA   * set de la couleur Bleu
	adda #$02	* increment de l'indice de couleur (x2)
	cmpa #$20	* si on atteint 32 alors sortie
	bne	SETBLACK
	
********************************************************************************  
* Boucle infinie
********************************************************************************	

INFINITELOOP
	bra INFINITELOOP
	