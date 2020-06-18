********************************************************************************
* Thomson TO8 - Fondu Noir                                                     *
********************************************************************************
* Auteur  : Benoit Rousseau                                                    *
* Date    : 18/06/2020                                                         *
* Licence : GNU General Public License                                         *
********************************************************************************
	ORG $6300

********************************************************************************  
* Debut du programme
********************************************************************************
BEGIN
	ORCC #$50	* desactive les interruptions	
	
********************************************************************************  
* Initialisation de la palette en noir
********************************************************************************

	LDD #$0000
SETBLACKPALETTE
	STA $E7DB	* determine l'indice de couleur
	STB $E7DA	* set de la couleur Vert et Rouge
	STB $E7DA   * set de la couleur Bleu
	ADDA #$02	* increment de l'indice de couleur (x2)
	CMPA #$20	* si on atteint 32 alors sortie
	BNE	SETBLACKPALETTE
	
********************************************************************************  
* Boucle infinie
********************************************************************************	

INFINITELOOP
	BRA INFINITELOOP
	