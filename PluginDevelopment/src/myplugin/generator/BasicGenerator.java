package myplugin.generator;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.List;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapperBuilder;
import freemarker.template.Template;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.fmmodel.FMType;
import myplugin.generator.options.GeneratorOptions;
import myplugin.generator.options.ProjectOptions;
import myplugin.generator.options.TypeMapping;


/**
 * Abstract generator that creates necessary environment for code generation 
 * (creating directory for code generation, fetching template, creating file with given name 
 * for code generation etc). It should be ancestor for all generators in this project. 
*/

public abstract class BasicGenerator {

	private GeneratorOptions generatorOptions; 
	private String outputPath;	
	private String templateName;
	private String templateDir;
	private String outputFileName;
	private boolean overwrite = false;
	private String filePackage;
	private Configuration cfg;
	private Template template;	
	private List<TypeMapping> typeMappings;
	
	
	public BasicGenerator(GeneratorOptions generatorOptions, List<TypeMapping> typeMappings) {
		this.generatorOptions = generatorOptions;
		this.outputPath = ProjectOptions.getProjectOptions().getGeneratedPath() + File.separator + generatorOptions.getOutputPath();
		this.templateName = generatorOptions.getTemplateName();
		this.templateDir = generatorOptions.getTemplateDir();
		this.outputFileName = generatorOptions.getOutputFileName();
		this.overwrite = generatorOptions.getOverwrite();
		this.filePackage = generatorOptions.getFilePackage();
		this.typeMappings = typeMappings;
	}

	public void generate() throws IOException {		
		if (outputPath == null) {
			throw new IOException("Output path is not defined!");
		}	
		if (templateName == null) {
			throw new IOException("Template name is not defined!");
		}
		if (outputFileName == null) {
			throw new IOException("Output file name is not defined!");
		}
		if (filePackage == null) {
			throw new IOException("Package name for code generation is not defined!");
		}

		cfg = new Configuration(Configuration.DEFAULT_INCOMPATIBLE_IMPROVEMENTS);		

		final String tName = templateName + ".ftl";
		
		outputPath = outputPath.replace("{1}", FMModel.getInstance().getApplication().getName());
				
		try {
			cfg.setDirectoryForTemplateLoading(new File(templateDir));
			template = cfg.getTemplate(tName);
			DefaultObjectWrapperBuilder builder = 
					new DefaultObjectWrapperBuilder(cfg.getIncompatibleImprovements());
			cfg.setObjectWrapper(builder.build());
			
		} catch (IOException e) {
			throw new IOException("Can't find template " + tName + ".", e);
		}
		
		try {
			File op = new File(outputPath);
			if (!op.exists() && !op.mkdirs()) {
					throw new IOException(
							"An error occurred during folder creation " + outputPath);
			}
		} catch (Exception e) {
			throw new IOException("Error creating output file");
		}

	}

	public Writer getWriter(String fileNamePart, String packageName) throws IOException {
		if (packageName != filePackage && !packageName.isEmpty()) {
			packageName.replace(".", File.separator);		
			filePackage = packageName;
		}
				
		String fullPath = outputPath
				+ File.separator
				+ (filePackage.isEmpty() ? "" : packageToPath(filePackage, fileNamePart)
						+ File.separator)
				+ outputFileName.replace("{0}", fileNamePart);

		File of = new File(fullPath);
		if (!of.getParentFile().exists()) {
			if (!of.getParentFile().mkdirs()) {
				throw new IOException("An error occurred during output folder creation "
						+ outputPath);
			}
		}

		System.out.println(of.getPath());
		System.out.println(of.getName());

		if (!isOverwrite() && of.exists()) {
			return null;
		}

		return new OutputStreamWriter(new FileOutputStream(of));

	}

	protected String packageToPath(String pack, String fileNamePart) {
		pack = pack.replace(".", File.separator);
		if(pack.contains("{0}")) {
			return pack.replace("{0}", fileNamePart.substring(0, 1).toLowerCase() + fileNamePart.substring(1));
		}
		
		return pack;
	}
	
	protected FMType getCorrectType(FMType type, String destination) {
		FMType newType = new FMType(type.getName(), type.getTypePackage());
		for (TypeMapping tm : typeMappings) {
			if(destination.equals("frontend") && tm.getuMLType().equalsIgnoreCase(type.getName())) {
				newType.setName(tm.getJsType()); 
				break;
			}
			else if(destination.equals("backend") && tm.getuMLType().equalsIgnoreCase(type.getName())) {
				newType.setName(tm.getJavaType()); 
				newType.setTypePackage(tm.getLibraryName());
				break;
			}
		}
		return newType;
	}
	
	protected static String formatInput(String s) {
		   return s.replaceAll(
		      String.format("%s|%s|%s",
		         "(?<=[A-Z])(?=[A-Z][a-z])",
		         "(?<=[^A-Z])(?=[A-Z])",
		         "(?<=[A-Za-z])(?=[^A-Za-z])"
		      ),
		      "-"
		   );
		}

	public boolean isOverwrite() {
		return overwrite;
	}

	public void setOverwrite(boolean overwrite) {
		this.overwrite = overwrite;
	}

	public Writer getWriter() throws IOException {
		return getWriter("", filePackage);

	}

	public void setOutputPath(String output) {
		this.outputPath = output;
	}

	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}
	
	public void setTemplateDir(String templateDir) {
		this.templateDir = templateDir;
	}

	public void setOutputFileName(String outputFileName) {
		this.outputFileName = outputFileName;
	}		
	
	public Configuration getCfg() {
		return cfg;
	}

	public void setCfg(Configuration cfg) {
		this.cfg = cfg;
	}

	public Template getTemplate() {
		return template;
	}

	public void setTemplate(Template template) {
		this.template = template;
	}

	public String getOutputPath() {
		return outputPath;
	}

	public String getTemplateName() {
		return templateName;
	}
	
	public String getTemplateDir() {
		return templateDir;
	}

	public String getOutputFileName() {
		return outputFileName;
	}

	public String getFilePackage() {
		return filePackage;
	}

	public void setFilePackage(String filePackage) {
		this.filePackage = filePackage;
	}
	
	public List<TypeMapping> getTypeMappings() {
		return typeMappings;
	}

	public void setTypeMappings(List<TypeMapping> typeMappings) {
		this.typeMappings = typeMappings;
	}

}
