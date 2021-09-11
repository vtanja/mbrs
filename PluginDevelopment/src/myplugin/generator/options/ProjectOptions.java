package myplugin.generator.options;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.StaxDriver;
 
/** ProjectOptions: singleton class that guides code generation process
 * @ToDo: enable save to xml file and load from xml file for this class */

public class ProjectOptions implements Serializable{
	//List of UML 2.0 to java (or any other destination language) mappings	
	private List<TypeMapping> typeMappings = new ArrayList<TypeMapping>();
	
	//Hash map for linking generators with its options
	private Map<String, GeneratorOptions> generatorOptions = new HashMap<String, GeneratorOptions>();
	
	//path to generated folders
	private String generatedPath = "";
	
	public String getGeneratedPath() {
		return generatedPath;
	}

	public void setGeneratedPath(String generatedPath) {
		this.generatedPath = generatedPath;
	}

	private static ProjectOptions projectOptions = null; 
	
	public List<TypeMapping> getTypeMappings() {
		return typeMappings;
	}

	public void setTypeMappings(List<TypeMapping> typeMappings) {
		this.typeMappings = typeMappings;
	}

	public Map<String, GeneratorOptions> getGeneratorOptions() {
		return generatorOptions;
	}

	public void setGeneratorOptions(Map<String, GeneratorOptions> generatorOptions) {
		this.generatorOptions = generatorOptions;
	}
	
	private ProjectOptions() {		
		
	}
	
	public static ProjectOptions getProjectOptions() {
		if (projectOptions ==null) { 
			projectOptions = new ProjectOptions();	
		}	
		return projectOptions;
	}

	public static void toXML(String filePath) throws IOException{
		ProjectOptions projectOptions = ProjectOptions.getProjectOptions();
		XStream xstream = new XStream(new StaxDriver());
		xstream.toXML(projectOptions, new FileWriter(filePath));
	}
	
	public static ProjectOptions fromXML(String path, String fileName) throws FileNotFoundException{
		FileReader fileReader = new FileReader(path+File.separator+fileName);
		XStream xstream = new XStream(new StaxDriver());
		ProjectOptions projectOptions = (ProjectOptions) xstream.fromXML(fileReader);
		
		for (GeneratorOptions option : projectOptions.getGeneratorOptions().values()) {
			option.setTemplateDir(path + File.separator + option.getTemplateDir());
		}
		
		return projectOptions;
	}
}
