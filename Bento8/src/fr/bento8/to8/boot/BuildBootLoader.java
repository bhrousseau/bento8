package fr.bento8.to8.boot;

public class BuildBootLoader
{
  public static void main(String[] args)
  {
	try
	{
		if (args.length==1) {
			// Génération d'un bootloader a partir d'un BIN
			BootLoader bootLoader = new BootLoader();
			byte[] bootLoaderBytes = bootLoader.encodeBootLoader(args[0]);
			System.out.print("bootLoader: <");
			for (int i = 0; i < bootLoaderBytes.length; i++) {
				System.out.print(String.format("%02X", (0xFF & bootLoaderBytes[i])));
			}
			System.out.println(">");
		}
		else {
			System.out.println("Parametres invalides !");
		}
	} 
    catch (Exception e)
    {
        e.printStackTrace(); 
        System.out.println(e); 
    }
  }
}
