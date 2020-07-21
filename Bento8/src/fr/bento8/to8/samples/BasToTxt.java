package fr.bento8.to8.samples;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import fr.bento8.to8.basic.BasicConverter;

/**
 * @author Benoît Rousseau
 * @version 1.0
 *
 */
public class BasToTxt
{

	/**
	 * Effectue la conversion d'un fichier BASIC (.BAS) TO8 Thomson en fichier Texte
	 * 
	 * @param args nom du fichier .BAS a convertir
	 */
	public static void main(String[] args)
	{
		try {
			
			String basFileName = args[0];
			
			BasicConverter bc = new BasicConverter();
			bc.load(basFileName);
			byte[] txtBytes = bc.convertToAscii();

			Path outputFile = Paths.get(basFileName.substring(0, basFileName.lastIndexOf('.'))+".txt");
			Files.deleteIfExists(outputFile);
			Files.createFile(outputFile);
			Files.write(outputFile, txtBytes);

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}
	}
}
