package myplugin.generator;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

import javax.swing.JOptionPane;

import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.options.ProjectOptions;


public class InitialProjectGenerator {
	public void generate() throws IOException{
		
		String appName = FMModel.getInstance().getApplication().getName();
		
		String generatePath = ProjectOptions.getProjectOptions().getGeneratedPath();
		
		String sourcePath = ProjectOptions.getProjectOptions().getSourcesPath();
		
		generateFrontend(appName, generatePath, sourcePath);
		
		generateResources(appName, generatePath, sourcePath);
		
		generateFilesInSrc(appName, generatePath, sourcePath);
		
				
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
	
	private void generateFrontend(String appName, String generatePath, String sourcePath) throws IOException {
		String sourceLocation = sourcePath + File.separator + "frontend\\demo";
		File srcDir = new File(sourceLocation);

		String destinationLocation = generatePath + File.separator + "frontend\\"+appName;
		File destDir = new File(destinationLocation);
		
		copyDirectory(srcDir, destDir);
	}
	
	private void generateFilesInSrc(String appName, String generatePath, String sourcePath) throws IOException {
		String sourceLocation = sourcePath + File.separator + "backend\\app";
		File srcDir = new File(sourceLocation);

		String destinationLocation = generatePath + File.separator + "backend\\"+appName;
		File destDir = new File(destinationLocation);
		
		copyDirectory(srcDir, destDir);
	}
	
	private void generateResources(String appName, String generatePath, String sourcePath) throws IOException{
		String sourceLocation = sourcePath + File.separator + "backend\\resources";
		File srcDir = new File(sourceLocation);

		String destinationLocation = generatePath + File.separator + "backend\\"+appName+"\\src\\main\\resources";
		File destDir = new File(destinationLocation);
		
		copyDirectory(srcDir, destDir);
	}

}
