package myplugin.generator;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

import javax.swing.JOptionPane;

import myplugin.generator.fmmodel.FMModel;


public class InitialProjectGenerator {
	public void generate() throws IOException{
		
		String appName = FMModel.getInstance().getApplication().getName();
		
		generateFrontend(appName);
		
		generateResources(appName);
		
		generateFilesInSrc(appName);
		
				
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
	
	private void generateFrontend(String appName) throws IOException {
		String sourceLocation = "C:\\Users\\tanja\\OneDrive\\Documents\\GitHub\\mbrs\\PluginDevelopment\\resources\\initialProjects\\frontend\\demo";
		File srcDir = new File(sourceLocation);

		String destinationLocation = "C:\\temp\\frontend\\"+appName;
		File destDir = new File(destinationLocation);
		
		copyDirectory(srcDir, destDir);
	}
	
	private void generateFilesInSrc(String appName) throws IOException {
		String sourceLocation = "C:\\Users\\tanja\\OneDrive\\Documents\\GitHub\\mbrs\\PluginDevelopment\\resources\\initialProjects\\backend\\app";
		File srcDir = new File(sourceLocation);

		String destinationLocation = "C:\\temp\\backend\\"+appName;
		File destDir = new File(destinationLocation);
		
		copyDirectory(srcDir, destDir);
	}
	
	private void generateResources(String appName) throws IOException{
		String sourceLocation = "C:\\Users\\tanja\\OneDrive\\Documents\\GitHub\\mbrs\\PluginDevelopment\\resources\\initialProjects\\backend\\resources";
		File srcDir = new File(sourceLocation);

		String destinationLocation = "C:\\temp\\backend\\"+appName+"\\src\\main\\resources";
		File destDir = new File(destinationLocation);
		
		copyDirectory(srcDir, destDir);
	}

}
