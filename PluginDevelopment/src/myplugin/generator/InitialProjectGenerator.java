package myplugin.generator;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

import javax.swing.JOptionPane;



public class InitialProjectGenerator {
	public void generate() throws IOException{
		String sourceLocation = "D:\\mbrs\\PluginDevelopment\\resources\\initialProjects\\backend";
		File srcDir = new File(sourceLocation);

		String destinationLocation = "D:\\temp\\backend";
		File destDir = new File(destinationLocation);
		
		copyDirectory(srcDir, destDir);
		
		sourceLocation = "D:\\mbrs\\PluginDevelopment\\resources\\initialProjects\\frontend";
		srcDir = new File(sourceLocation);

		destinationLocation = "D:\\temp\\frontend";
		destDir = new File(destinationLocation);
		
		copyDirectory(srcDir, destDir);
		
		JOptionPane.showMessageDialog(null, "Initial project generated");
	}

	private static void copyDirectory(File sourceDirectory, File destinationDirectory) throws IOException {
	    if (!destinationDirectory.exists()) {
	        destinationDirectory.mkdir();
	    }
	    for (String f : sourceDirectory.list()) {
	        copyDirectoryCompatibityMode(new File(sourceDirectory, f), new File(destinationDirectory, f));
	    }
	}
	
	private static void copyDirectoryCompatibityMode(File source, File destination) throws IOException {
	    if (source.isDirectory()) {
	        copyDirectory(source, destination);
	    } else {
	    	Files.copy(source.toPath(), destination.toPath(), StandardCopyOption.REPLACE_EXISTING);
	    }
	}
	
	

}
