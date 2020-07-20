package fr.bento8.to8.samples;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Properties;

import fr.bento8.to8.boot.Bootloader;
import fr.bento8.to8.disk.FdUtil;

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
		int i, j=0, k;
		try {
			byte[] basBytes = Files.readAllBytes(Paths.get(args[0]));
			byte[] txtBytes = new byte[basBytes.length*8];



			save(args[0], txtBytes);

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}
	}

	/**
	 * Eciture (et remplacement) du fichier txt
	 * 
	 * @param outputFileName nom du fichier a écrire
	 */
	public static void save(String outputFileName, byte[] txtBytes) {
		Path outputFile = Paths.get(outputFileName+".txt");
		try {
			Files.deleteIfExists(outputFile);
			Files.createFile(outputFile);
			Files.write(outputFile, txtBytes);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
