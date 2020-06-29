package fr.bento8.to8.samples;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Properties;

import fr.bento8.to8.boot.Bootloader;
import fr.bento8.to8.disk.FdUtil;

/**
 * @author Benoît Rousseau
 * @version 1.0
 *
 */
public class BuildBootDisk
{
	private final static String tempFile = "TMP.BIN";
	private static String bootFile;
	private static String mainFile;
	private static String outputFileName;
	private static String compiler;

	/**
	 * Génère une image de disquette dans les formats .fd et .sd pour 
	 * l'ordinateur Thomson TO8.
	 * L'image de disquette contient un secteur d'amorçage et le code
	 * principal qui sera chargé en mémoire par le code d'amorçage.
	 * Ce programme n'utilise donc pas de système de fichier.
	 * 
	 * Plan d'adressage d'une disquette Thomson TO8 ou format .fd (655360 octets ou 640kiB)
	 * Identifiant des faces: 0-1
	 * Pour chaque face, identifiant des pistes: 0-79
	 * Pour chaque piste, identifiant des secteurs: 1-16
	 * Taille d'un secteur: 256 octets
	 * Secteur d'amorçage: face=0 piste=0 secteur=1 octets=0-127
	 * Le fichier .fd débute donc avec les 127 octets du secteur d'amorçage. 
	 * 
	 * Le format .sd (1310720 octets ou 1,25MiB) reprend la même structure que le format .fd mais ajoute
	 * 256 octets à la fin de chaque secteur avec la valeur FF
	 * 
	 * Remarque i lest posible dans un fichier .fd ou .sd de concaténer deux disquettes
	 * Cette fonctionnalité n'est pas implémentée ici.
	 * 
	 * @param args nom du fichier properties contenant les données de configuration
	 */
	public static void main(String[] args)
	{
		// Chargement du fichier de configuration
		try (InputStream input = new FileInputStream(args[0])) {
			Properties prop = new Properties();
			prop.load(input);

			bootFile = prop.getProperty("bootfile");
			mainFile = prop.getProperty("mainfile");
			outputFileName = prop.getProperty("outputfile");
			compiler = prop.getProperty("compiler");	

			FdUtil fd = new FdUtil();

			if (compile(bootFile) == 0) {

				// Traitement du binaire issu de la compilation et génération du secteur d'amorçage
				Bootloader bootLoader = new Bootloader();
				byte[] bootLoaderBytes = bootLoader.encodeBootLoader(tempFile);

				fd.setIndex(0, 0, 1);
				fd.write(bootLoaderBytes);

				if (compile(mainFile) == 0) {

					// Ecriture du code principal
					byte[] mainBytes = Files.readAllBytes(Paths.get(tempFile));

					fd.setIndex(0, 0, 2);
					fd.write(mainBytes);

					fd.save(outputFileName);
					fd.saveToSd(outputFileName);
				}
			}
		}
		catch (Exception e)
		{
			e.printStackTrace(); 
			System.out.println(e); 
		}
	}

	/**
	 * Effectue la compilation du code assembleur
	 * 
	 * @param asmFile fichier contenant le code assembleur a compiler
	 * @return
	 */
	private static int compile(String asmFile) {
		// l'option -bd permet la génération d'un binaire brut (sans entête)
		try {
			// Purge des fichiers temporaires
			Files.deleteIfExists(Paths.get(tempFile));
			Files.deleteIfExists(Paths.get("codes.lst"));

			// Lancement de la compilation du fichier contenant le code de boot
			System.out.println("**************** COMPILE "+asmFile+" ****************");
			Process p = new ProcessBuilder(compiler, "-bd", asmFile, tempFile).start();
			BufferedReader br=new BufferedReader(new InputStreamReader(p.getInputStream()));
			String line;

			while((line=br.readLine())!=null){
				System.out.println(line);
			}

			return p.waitFor();

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e); 
			return -1;
		}
	}
}
