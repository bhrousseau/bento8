package fr.bento8.to8.samples;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import fr.bento8.to8.boot.BootLoader;
import fr.bento8.util.properties.ReadProperties;

public class BuildBootDisk
{
	// Plan d'adressage - disquette taille 655360 octets (640ko)
	// face (0-1) track (0-79) sector (1-16: 256 octets)
	// face=0 track=0 sector=1 : 0 - 127 : Secteur d'amorçage

	static ReadProperties confProperties;
	static byte[] fdBytes = new byte[655360];
	static byte[] bootLoaderBytes;
	static String tempFile = "TMP.BIN";

	public static void main(String[] args)
	{
		int face=0, track=0, sector=0;
		// SD format : insère 256 octets FF après chaque secteur de la disquette Thomson 

		try {
			confProperties = new ReadProperties(args[0]);

			// ********** Load Boot code **********

			// Generate binary code from assembly code
			Files.deleteIfExists(Paths.get(tempFile));
			Files.deleteIfExists(Paths.get("codes.lst"));
			Process p = new ProcessBuilder(confProperties.compiler, "-oWE", confProperties.bootfile, tempFile).start();
			BufferedReader br=new BufferedReader(new InputStreamReader(p.getInputStream()));
			String line;
			System.out.println("**************** COMPILE BOOT CODE ****************");
			while((line=br.readLine())!=null){
				System.out.println(line);
			}

			int result = p.waitFor();
			if (result != 0) {
				BootLoader bootLoader = new BootLoader();
				bootLoaderBytes = bootLoader.encodeBootLoader(tempFile);
				Files.deleteIfExists(Paths.get(tempFile));

				// copy Bootloader to face 0 track 0 sector 1
				for (int i=0; i<bootLoaderBytes.length; i++) {
					fdBytes[i] = bootLoaderBytes[i];
				}

				// ********** Load Main code **********

				// Generate binary code from assembly code
				Files.deleteIfExists(Paths.get(tempFile));
				Files.deleteIfExists(Paths.get("codes.lst"));
				p = new ProcessBuilder(confProperties.compiler, "-bd", confProperties.mainfile+".TMP", tempFile).start();
				br=new BufferedReader(new InputStreamReader(p.getInputStream()));
				System.out.println("**************** COMPILE MAIN CODE ****************");
				while((line=br.readLine())!=null){
					System.out.println(line);
				}

				result = p.waitFor();
				if (result != 0) {
					// Write Main Code
					face=0;
					track=0;
					sector=2;
					byte[] mainBIN = Files.readAllBytes(Paths.get(tempFile));
					System.out.println("Ecriture en :"+((face*327680)+(track*4096)+((sector-1)*256))+" ($"+String.format("%1$04X",((face*327680)+(track*4096)+((sector-1)*256)))+")");
					for (int i = 0; i < mainBIN.length; i++) {
						fdBytes[i+(face*327680)+(track*4096)+((sector-1)*256)] = mainBIN[i];
					}

					// Write output file
					Path outputfile = Paths.get(confProperties.outputfile);
					Files.deleteIfExists(outputfile);
					Files.createFile(outputfile);
					Files.write(outputfile, fdBytes);
				}
			}
		}
		catch (Exception e)
		{
			e.printStackTrace(); 
			System.out.println(e); 
		}
	}
}
