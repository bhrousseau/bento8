package fr.bento8.to8.basic;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

/**
 * @author Benoît Rousseau
 * @version 1.0
 *
 */
public class BasicConverter {

	byte[] basBytes;
	int fileSize;

	public static byte[][] keywords = {
			{0x45, 0x4e, 0x44},	//	END
			{0x46, 0x4f, 0x52},	//	FOR
			{0x4e, 0x45, 0x58, 0x54},	//	NEXT
			{0x44, 0x41, 0x54, 0x41},	//	DATA
			{0x44, 0x49, 0x4d},	//	DIM
			{0x52, 0x45, 0x41, 0x44},	//	READ
			{},
			{0x47, 0x4f},	//	GO
			{},
			{0x49, 0x46},	//	IF
			{0x52, 0x45, 0x53, 0x54, 0x4f, 0x52, 0x45},	//	RESTORE
			{0x52, 0x45, 0x54, 0x55, 0x52, 0x4e},	//	RETURN
			{0x27},	//	'
			{},
			{0x53, 0x54, 0x4f, 0x50},	//	STOP
			{0x45, 0x4c, 0x53, 0x45},	//	ELSE
			{},
			{},
			{},
			{0x44, 0x45, 0x46, 0x49, 0x4e, 0x54},	//	DEFINT
			{},
			{},
			{0x4f, 0x4e},	//	ON
			{},
			{0x45, 0x52, 0x52, 0x4f, 0x52},	//	ERROR
			{0x52, 0x45, 0x53, 0x55, 0x4d, 0x45},	//	RESUME
			{},
			{},
			{0x4c, 0x4f, 0x43, 0x41, 0x54, 0x45},	//	LOCATE
			{0x43, 0x4c, 0x53},	//	CLS
			{0x43, 0x4f, 0x4e, 0x53, 0x4f, 0x4c, 0x45},	//	CONSOLE
			{0x50, 0x53, 0x45, 0x54},	//	PSET
			{},
			{},
			{0x45, 0x58, 0x45, 0x43},	//	EXEC
			{0x42, 0x45, 0x45, 0x50},	//	BEEP
			{0x43, 0x4f, 0x4c, 0x4f, 0x52},	//	COLOR
			{0x4c, 0x49, 0x4e, 0x45},	//	LINE
			{0x42, 0x4f, 0x58},	//	BOX
			{},
			{0x41, 0x54, 0x54, 0x52, 0x42},	//	ATTRB
			{0x68, 0x69, 0x70},	//	DEF
			{0x50, 0x4f, 0x4b, 0x45},	//	POKE
			{0x50, 0x52, 0x49, 0x4e, 0x54},	//	PRINT
			{},
			{},
			{0x43, 0x4c, 0x45, 0x41, 0x52},	//	CLEAR
			{},
			{0x4b, 0x45, 0x59},	//	KEY
			{},
			{},
			{0x4c, 0x4f, 0x41, 0x44},	//	LOAD
			{},
			{0x4f, 0x50, 0x45, 0x4e},	//	OPEN
			{0x43, 0x4c, 0x4f, 0x53, 0x45},	//	CLOSE
			{0x49, 0x4e, 0x50, 0x45, 0x4e},	//	INPEN
			{},
			{0x50, 0x4c, 0x41, 0x59},	//	PLAY
			{0x54, 0x41, 0x42, 0x28},	//	TAB(
			{0x54, 0x4f},	//	TO
			{0x53, 0x55, 0x42},	//	SUB
			{0x46, 0x4e},	//	FN
			{},
			{0x55, 0x53, 0x49, 0x4e, 0x47},	//	USING
			{},
			{0x45, 0x52, 0x4c},	//	ERL
			{0x45, 0x52, 0x52},	//	ERR
			{},
			{0x54, 0x48, 0x45, 0x4e},	//	THEN
			{0x4e, 0x4f, 0x54},	//	NOT
			{0x53, 0x54, 0x45, 0x50},	//	STEP
			{0x2b},	//	+
			{0x2d},	//	-
			{0x45, 0x4e, 0x44},	//	*
			{0x2f},	//	/
			{},
			{0x41, 0x4e, 0x44},	//	AND
			{0x4f, 0x52},	//	OR
			{},
			{},
			{},
			{0x4d, 0x4f, 0x44},	//	MOD
			{0x40},	//	@
			{0x3e},	//	>
			{0x3d},	//	=
			{0x3c},	//	<
			{0x44, 0x53, 0x4b, 0x49, 0x4e, 0x49},	//	DSKINI
			{},
			{},
			{},
			{},
			{},
			{},
			{0x50, 0x55, 0x54},	//	PUT
			{0x47, 0x45, 0x54},	//	GET
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{0x43, 0x4f, 0x50, 0x59},	//	COPY
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{0x44, 0x4f},	//	DO
			{0x4c, 0x4f, 0x4f, 0x50},	//	LOOP
			{0x45, 0x58, 0x49, 0x54},	//	EXIT
			{},
			{},
			{},
			{},
			{},
			{},
			{0x54, 0x55, 0x52, 0x54, 0x4c, 0x45},	//	TURTLE
	};

	public static byte[][] functions = {
			{},
			{0x49, 0x4e, 0x54},	//	INT
			{0x41, 0x42, 0x53},	//	ABS
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{0x50, 0x45, 0x45, 0x4b},	//	PEEK
			{0x4c, 0x45, 0x4e},	//	LEN
			{},
			{0x56, 0x41, 0x4c},	//	VAL
			{0x41, 0x53, 0x43},	//	ASC
			{0x43, 0x48, 0x52, 0x24},	//	CHR$
			{},
			{},
			{},
			{},
			{},
			{0x48, 0x45, 0x58, 0x24},	//	HEX$
			{},
			{},
			{},
			{0x47, 0x52, 0x24},	//	GR$
			{0x4c, 0x45, 0x46, 0x54, 0x24},	//	LEFT$
			{0x52, 0x49, 0x47, 0x48, 0x54, 0x24},	//	RIGHT$
			{0x4d, 0x49, 0x44, 0x24},	//	MID$
			{},
			{0x56, 0x41, 0x52, 0x50, 0x54, 0x52},	//	VARPTR
			{0x52, 0x4e, 0x44},	//	RND
			{0x49, 0x4e, 0x4b, 0x45, 0x59, 0x24},	//	INKEY$
			{0x49, 0x4e, 0x50, 0x55, 0x54, 0x24},	//	INPUT$
			{0x43, 0x52, 0x53, 0x4c, 0x49, 0x4e},	//	CRSLIN
			{},
			{0x53, 0x43, 0x52, 0x45, 0x45, 0x4e},	//	SCREEN
			{0x50, 0x4f, 0x53},	//	POS
			{0x50, 0x54, 0x52, 0x49, 0x47},	//	PTRIG
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{0x53, 0x50, 0x41, 0x43, 0x45, 0x24},	//	SPACE$
			{0x53, 0x54, 0x52, 0x49, 0x4e, 0x47, 0x24},	//	STRING$
			{0x44, 0x53, 0x4b, 0x49, 0x24},	//	DSKI$
			{0x46, 0x4b, 0x45, 0x59, 0x24},	//	FKEY$
			{},
			{},
			{},
			{},
			{},
			{},
			{0x50, 0x41, 0x4c, 0x45, 0x54, 0x54, 0x45},	//	PALETTE
			{},
			{0x48, 0x45, 0x41, 0x44},	//	HEAD
			{0x52, 0x4f, 0x54},	//	ROT
			{0x53, 0x48, 0x4f, 0x57},	//	SHOW
			{0x5a, 0x4f, 0x4f, 0x4d},	//	ZOOM
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
	};

	public BasicConverter() {

	}

	public void load(String fileName) {
		try {
			basBytes = Files.readAllBytes(Paths.get(fileName));

			byte fileType = basBytes[0];
			if (fileType != (byte) 0xff) {
				throw new IllegalStateException("Type de fichier non reconnu: Le premier octet "+fileType+" n'est pas 0xff");
			}

			fileSize = basBytes[1] << 8 & 0xFF00 | basBytes[2] & 0xFF;
			System.out.println("Taille du fichier "+fileName+": "+fileSize+" octets.");

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public byte[] convertToAscii() {
		if (basBytes == null) {
			return null;
		}

		byte[] txtBytes = new byte[basBytes.length*8]; // On réserve de l'espace supplémentaire pour le remplacement des codes par les mots clés
		int i=3, j=0, k, l; // La première ligne commence a l'index 3
		int linelength, lineNumber;
		String lineNumberStr;

		while (i+10<basBytes.length) {
			// Lecture ligne à ligne du fichier basic
			linelength = basBytes[i++] << 8 & 0xFF00 | basBytes[i++] & 0xFF;
			lineNumber = basBytes[i++] << 8 & 0xFF00 | basBytes[i++] & 0xFF;
			lineNumberStr = String.valueOf(lineNumber);
			System.out.println("Lecture ligne: "+lineNumberStr+" longueur: "+linelength);

			// Ajout du numéro de ligne et de l'espace
			for (l = 0; l < lineNumberStr.length(); l++) {
				txtBytes[j++] = (byte) lineNumberStr.charAt(l);
			}
			txtBytes[j++] = (byte) 0x20;

			//System.out.println(String.format("%02x", basBytes[i]));

			while (basBytes[i] != (byte) 0x00) { // une fin de ligne se termine par la valeur 0x00

				// Gestion des caractères accentués
				switch(basBytes[i]) {
				case (byte) 0x16:
					switch(basBytes[++i]) {
					case (byte) 0x41:
						switch(basBytes[++i]) {
						case (byte) 0x61:
							txtBytes[j++] = (byte) 0xe0; //à
						break;
						case (byte) 0x65:
							txtBytes[j++] = (byte) 0xe8; //è
						break;
						case (byte) 0x75:
							txtBytes[j++] = (byte) 0xf6; //ù
						break;
						default:
							//throw new IllegalStateException("Caractère accentué 0x16 0x41 "+String.format("0x%02X", basBytes[i-1])+" non reconnu.");
							System.out.println("Caractère accentué 0x16 0x41 "+String.format("0x%02X", basBytes[i-1])+" non reconnu.");
						}
					case (byte) 0x42:
						switch(basBytes[++i]) {
						case (byte) 0x65:
							txtBytes[j++] = (byte) 0xe9; //é
						break;
						default:
							//throw new IllegalStateException("Caractère accentué 0x16 0x42 "+String.format("0x%02X", basBytes[i-1])+" non reconnu.");
							System.out.println("Caractère accentué 0x16 0x42 "+String.format("0x%02X", basBytes[i-1])+" non reconnu.");
						}
					case (byte) 0x43:
						switch(basBytes[++i]) {
						case (byte) 0x61:
							txtBytes[j++] = (byte) 0xe2; //â
						break;
						case (byte) 0x65:
							txtBytes[j++] = (byte) 0xea; //ê
						break;
						case (byte) 0x69:
							txtBytes[j++] = (byte) 0xee; //î
						break;
						case (byte) 0x6f:
							txtBytes[j++] = (byte) 0xf4; //ô
						break;
						case (byte) 0x75:
							txtBytes[j++] = (byte) 0xfb; //û
						break;
						default:
							//throw new IllegalStateException("Caractère accentué 0x16 0x43 "+String.format("0x%02X", basBytes[i-1])+" non reconnu.");
							System.out.println("Caractère accentué 0x16 0x43 "+String.format("0x%02X", basBytes[i-1])+" non reconnu.");
						}
					case (byte) 0x48:
						switch(basBytes[++i]) {
						case (byte) 0x65:
							txtBytes[j++] = (byte) 0xeb; //ë
						break;
						case (byte) 0x69:
							txtBytes[j++] = (byte) 0xef; //ï
						break;
						case (byte) 0x6f:
							txtBytes[j++] = (byte) 0xf6; //ö
						break;
						case (byte) 0x75:
							txtBytes[j++] = (byte) 0xfc; //ü
						break;
						default:
							//throw new IllegalStateException("Caractère accentué 0x16 0x48 "+String.format("0x%02X", basBytes[i-1])+" non reconnu.");
							System.out.println("Caractère accentué 0x16 0x48 "+String.format("0x%02X", basBytes[i-1])+" non reconnu.");
						}
					case (byte) 0x4b:
						switch(basBytes[++i]) {
						case (byte) 0x63:
							txtBytes[j++] = (byte) 0xe7; //ç
						break;
						default:
							//throw new IllegalStateException("Caractère accentué 0x16 0x4b "+String.format("0x%02X", basBytes[i-1])+" non reconnu.");
							System.out.println("Caractère accentué 0x16 0x4b "+String.format("0x%02X", basBytes[i-1])+" non reconnu.");
						}
					break;
					default:
						//throw new IllegalStateException("Caractère accentué 0x16 "+String.format("0x%02X", basBytes[i-1])+" "+String.format("0x%02X", basBytes[i])+" non reconnu.");
						System.out.println("Caractère accentué 0x16 "+String.format("0x%02X", basBytes[i-1])+" "+String.format("0x%02X", basBytes[i])+" non reconnu.");
					}				
				break;
				default:
					// Gestion des mots clés Basic
					//System.out.println(String.format("%02x", basBytes[i]));
					if (basBytes[i] < -7) {
						for (k = 0; k < keywords[basBytes[i]+128].length; k++) {
							txtBytes[j++] = keywords[basBytes[i]+128][k];
						}
					} else if (basBytes[i] == (byte) 0xFF) {
						// Gestion des fonctions Basic
						if (basBytes[++i] < -7) {
							for (k = 0; k < functions[basBytes[i]+128].length; k++) {
								txtBytes[j++] = functions[basBytes[i]+128][k];
							}
						} else {
							throw new IllegalStateException("Fonction non reconnue 0xFF "+String.format("0x%02X", basBytes[i+1])+" non reconnu.");
						}
					} else {
						// Caractère sans transcodage
						txtBytes[j++] = basBytes[i];
					}
				}
				i++;
			}
			i++;
			txtBytes[j++] = (byte) 0x0d;
			txtBytes[j++] = (byte) 0x0a;
		}
		return txtBytes;
	}	
}