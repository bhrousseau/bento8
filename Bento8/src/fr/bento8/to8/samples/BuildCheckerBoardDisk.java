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
 * @author Beno�t Rousseau
 * @version 1.0
 *
 */
public class BuildCheckerBoardDisk
{
	private final static String tempFile = "TMP.BIN";
	private static String bootFile;
	private static String mainFile;
	private static String outputFileName;
	private static String compiler;

	/**
	 * G�n�re une image de disquette dans les formats .fd et .sd pour 
	 * l'ordinateur Thomson TO8.
	 * L'image de disquette contient un secteur d'amor�age et le code
	 * principal qui sera charg� en m�moire par le code d'amor�age.
	 * Ce programme n'utilise donc pas de syst�me de fichier.
	 * 
	 * Plan d'adressage d'une disquette Thomson TO8 ou format .fd (655360 octets ou 640kiB)
	 * Identifiant des faces: 0-1
	 * Pour chaque face, identifiant des pistes: 0-79
	 * Pour chaque piste, identifiant des secteurs: 1-16
	 * Taille d'un secteur: 256 octets
	 * Secteur d'amor�age: face=0 piste=0 secteur=1 octets=0-127
	 * Le fichier .fd d�bute donc avec les 127 octets du secteur d'amor�age. 
	 * 
	 * Le format .sd (1310720 octets ou 1,25MiB) reprend la m�me structure que le format .fd mais ajoute
	 * 256 octets � la fin de chaque secteur avec la valeur FF
	 * 
	 * Remarque i lest posible dans un fichier .fd ou .sd de concat�ner deux disquettes
	 * Cette fonctionnalit� n'est pas impl�ment�e ici.
	 * 
	 * @param args nom du fichier properties contenant les donn�es de configuration
	 */
	public static void main(String[] args)
	{
		// Chargement du fichier de configuration
		try (InputStream input = new FileInputStream(args[0])) {
			Properties prop = new Properties();
			prop.load(input);

			bootFile = prop.getProperty("bootfile");
			outputFileName = prop.getProperty("outputfile");
			compiler = prop.getProperty("compiler");	

			FdUtil fd = new FdUtil();

			if (compile(bootFile) == 0) {

				// Traitement du binaire issu de la compilation et g�n�ration du secteur d'amor�age
				Bootloader bootLoader = new Bootloader();
				byte[] bootLoaderBytes = bootLoader.encodeBootLoader(tempFile);

				fd.setIndex(0, 0, 1);
				fd.write(bootLoaderBytes);

				fd.save(outputFileName);
				fd.saveToSd(outputFileName);
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
		// l'option -bd permet la g�n�ration d'un binaire brut (sans ent�te)
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
