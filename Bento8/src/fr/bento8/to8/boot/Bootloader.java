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

	public Bootloader() {
	}
	
	/**
	 * Encode le secteur d'amorçage pour l'écriture sur une disquette pour Thomson TO8
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
					// Copie du code d'amorçage compilé
					bootLoader[i] = (byte) (256 - bootLoaderBIN[i]);
					
					System.out.println("Index "+i+" :"+bootLoaderBIN[i]+" "+bootLoader[i]+" "+String.format("%02X", (0xFF & bootLoaderBIN[i]))+" "+String.format("%02X", (0xFF & bootLoader[i])));
					
					// Mise a jour de la somme de controle
					bootLoader[127] = (byte) (bootLoader[127] - bootLoader[i]);
				}
				
				for (i = 120; i <= 125; i++) {
					// Copie de la signature
					bootLoader[i] = signature[j++];
					
					// Mise a jour de la somme de controle
					bootLoader[127] = (byte) (bootLoader[127] - bootLoader[i]);
				}
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
