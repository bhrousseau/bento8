package fr.bento8.util.properties;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

public class ReadProperties {

	
	public String bootfile;
	public String mainfile;
	public String outputfile;
	public String compiler;

	public ReadProperties(String file) {
		try {
			List<String> allLines = Files.readAllLines(Paths.get(file));
			for (String line : allLines) {
				String[] splitedLine = line.split("=");
				if (splitedLine.length > 1) {
					splitedLine = splitedLine[1].split(";");
				}
				if (line.startsWith("bootfile=")) {
					bootfile=splitedLine[0];
				} else if (line.startsWith("mainfile=")) {
					mainfile=splitedLine[0];
				} else if (line.startsWith("outputfile=")) {
					outputfile=splitedLine[0];
				} else if (line.startsWith("compiler=")) {
					compiler=splitedLine[0];
				}
			}
		} catch (IOException ex) {
			ex.printStackTrace();
		}
    }
}