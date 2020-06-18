package fr.bento8.to8.boot;

import java.nio.file.Files;
import java.nio.file.Paths;

public class BootLoader {

	byte[] signature = {0x42, 0x41, 0x53, 0x49, 0x43, 0x32, 0x00}; // "BASIC2 "

	public BootLoader() {
	}
	
	public byte[] encodeBootLoader(String file) {
		byte[] bootLoader = new byte[128];
		int i;
		try {
			byte[] bootLoaderBIN = Files.readAllBytes(Paths.get(file));
					
			if (bootLoaderBIN[0] ==  (byte) 0x00 && bootLoaderBIN[1] ==  (byte) 0x00 && bootLoaderBIN[2] <=  (byte) 0x79) {
				bootLoader[127] = (byte) 0x55; // CHKSUM
				for (i = 0; i < bootLoaderBIN[2]; i++) {
					bootLoader[i] = (byte) (256 - bootLoaderBIN[i+5]);
					bootLoader[127] = (byte) (bootLoader[127] - bootLoader[i]);
				}
				
				while (i <= 119 ) {
					bootLoader[i++] = (byte) 0x00;
				}
				
				while (i <= 126 ) {
					bootLoader[i] = signature [i-120];
					bootLoader[127] = (byte) (bootLoader[127] - bootLoader[i++]);
				}
			} else {
				System.out.println("Le fichier BIN pour le bootloader doit contenir un code de 121 octets maximum. Taille actuelle: " + Integer.toHexString(bootLoaderBIN[1]) + Integer.toHexString(bootLoaderBIN[2]));
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}
		return bootLoader;
	}
	
	public byte[] decodeBootLoader(String file) {
		byte[] decodedBootLoader = new byte[128];
		int i;
		try {
			byte[] fd = Files.readAllBytes(Paths.get(file));

			for (i = 0; i < fd.length-signature.length; i++) {
				if (fd[i] == signature[0] && fd[i+1] == signature[1] && fd[i+2] == signature[2] && fd[i+3] == signature[3] && fd[i+4] == signature[4] && fd[i+5] == signature[5] && fd[i+6] == signature[6]) {
					for (int j = i-120, k = 0; j < i; j++) {
						decodedBootLoader[k++] = (byte) (256 - fd[j]);
					}
					break;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}
		return decodedBootLoader;
	}
}
