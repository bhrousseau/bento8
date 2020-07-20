package fr.bento8.to8.boot;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Arrays;

/**
 * @author Benoît Rousseau
 * @version 1.0
 *
 */
public class Bootloader {

	public byte[] signature = {0x42, 0x41, 0x53, 0x49, 0x43, 0x32}; // "BASIC2"
	public byte signatureSum = (byte) 0x6C; // (256-(66+65+83+73+67+50)%256)) Somme de contrôle de la signature

	public Bootloader() {
	}
	
	/**
	 * Encode le secteur d'amorçage d'une disquette Thomson TO8
	 * 
	 * Le secteur d'amorçage est présent en face=0 piste=0 secteur=1 octets=0-127 
	 * 
	 * Le code a exécuter est contenu en position 0 à 119 (encodé par un complément à 2 sur chaque octet)
	 * Le secteur d'amorçage contient "BASIC2" en position 120 à 125
	 * Le secteur d'amorçage contient la somme de contrôle en position 127
	 * 
	 * La somme de contrôle est vérifiée au chargement par le TO8 en effectuant :
	 *    - un complément à 2 sur tous les octets 0-126 (code+signature)
	 *    - une somme de ces octets
	 *    - l'ajout de la valeur 0x55
	 *      
	 * Il faut donc calculer la somme de contrôle en effectuant:
	 *    - la somme des octets du code (0-119) avant leur complément à 2
	 *    - ajouter la somme des octets (avec complément à 2) de la signature
	 *    - ajouter 0x55
	 * 
	 * Au lancement du basic (Touche 1, B, 2 ou C) le système execute la lecture du secteur d'amorçage (point d'entrée $E007)
	 * S'il est présent, le TO8 charge le code d'amorçage à l'adresse $6200, sinon il execute le Basic
	 * 
	 * @param file fichier binaire contenant le code compilé d'amorçage
	 * @return
	 */
	public byte[] encodeBootLoader(String file) {
		byte[] bootLoader = new byte[128];
		Arrays.fill(bootLoader, (byte) 0x00);
		int i,j=0;
		
		try {
			byte[] bootLoaderBIN = Files.readAllBytes(Paths.get(file));
			
			// Taille maximum de 120 octets pour le bootloader
			if (bootLoaderBIN.length <= 120) {
				
				// Initialisation de la somme de controle
				bootLoader[127] = (byte) 0x55;
				
				for (i = 0; i < bootLoaderBIN.length; i++) {
					// Ajout de l'octet courant (avant complément à 2) à la somme de contrôle
					bootLoader[127] = (byte) (bootLoader[127] + bootLoaderBIN[i]);
					
					// Encodage de l'octet par complément à 2
					bootLoader[i] = (byte) (256 - bootLoaderBIN[i]);
				}
				
				for (i = 120; i <= 125; i++) {
					// Copie de la signature (SANS complément à 2)
					bootLoader[i] = signature[j++];
				}
				
				// Ajout de la somme de la signature à la somme de contrôle
				bootLoader[127] = (byte) (bootLoader[127] + signatureSum);
				
			} else {
				System.out.println("Le fichier BIN pour le bootloader doit contenir un code de 120 octets maximum. Taille actuelle: " + bootLoaderBIN.length);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}
		return bootLoader;
	}
}

//0E54 7E    JMP  E007   * Appuye sur B

// Appuye sur C
//E025 

//E007 16    LBRA E028
//E00A 16    LBRA E048
//E00D 16    LBRA E02D
//E010 16    LBRA DFB2
//E013 16    LBRA E094
//E016 16    LBRA E073
//E019 16    LBRA E01A
//E01C 16    LBRA E073
//E01F 16    LBRA DFB8
//E022 16    LBRA DFD6
//E025 16    LBRA E06D
//E028 17    LBSR DFBB
//E02B 0F    CLR  49
//E02D 17    LBSR DFD1
//E030 25    BCS  E067
//E032 17    LBSR E007
//E035 25    BCS  E067
//E037 CC    LDD  #0044
//E03A DD    STD  4C      * DK.SEC Secteur a lire : 0
//E03C CE    LDU  #6200   * 
//E03F DF    STU  4F      * DK.BUF Destination des donnees lues : 6200
//E041 17    LBSR E03C
//E044 DE    LDU  4F
//E046 25    BCS  E067
//E048 17    LBSR DFED
//E04B 10 8E LDY  #627F
//E04F 34    PSHS Y,
//E051 86    LDA  #55     * Init checksum
//E053 6A    DEC  ,U      * octet-1
//E055 63    COM  ,U      * Complément à 2
//E057 AB    ADDA ,U+     * On ajoute le contenu de l'octet au checksum et on avance
//E059 11 A3 CMPU ,S      * Compare U a S (fin du buffer)
//E05C 26    BNE  E053    * Non on continue a lire les octets
//E05E 35    PULS Y,
//E060 A1    CMPA ,U      * On compare le chksum calculé (A) avec le chksum stocké sur Dsk (U)
//E062 26    BNE  E067    * Chksum KO on lance le Basic
//E064 7E    JMP  6200    * Chksum OK on lance le programme en 6200
