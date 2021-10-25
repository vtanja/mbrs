package myplugin.generator;

import java.io.IOException;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;

import javax.swing.JOptionPane;

import freemarker.template.TemplateException;

import myplugin.generator.fmmodel.FMClass;
import myplugin.generator.fmmodel.FMIdentityProperty;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.fmmodel.FMProperty;
import myplugin.generator.fmmodel.FMType;
import myplugin.generator.fmmodel.FMPersistentProperty;
import myplugin.generator.fmmodel.FMLinkedProperty;
import myplugin.generator.options.GeneratorOptions;
import myplugin.generator.options.TypeMapping;

public class FrontDTOGenerator extends BasicGenerator {
	
	public FrontDTOGenerator(GeneratorOptions generatorOptions, List<TypeMapping> typeMappings) {
		super(generatorOptions, typeMappings);
	}
	
	public void generate() {
		try {
			super.generate();
		} catch (IOException e) {
			JOptionPane.showMessageDialog(null, e.getMessage());
		}
		
		List<FMClass> classes = FMModel.getInstance().getClasses();
		for (int i = 0; i < classes.size(); i++) {
			FMClass cl = classes.get(i);
			Writer out;
			Map<String, Object> context = new HashMap<String, Object>();
			try {
				out = getWriter(formatInput(cl.getName()).toLowerCase(), cl.getTypePackage());
				if (out != null) {
					context.clear();
					context.put("class", cl);
					context.put("name", cl.getName());
					context.put("properties", cl.getProperties());
					
					Map<String, String> imports = new HashMap<String, String>();
					for(FMType pack : cl.getImportedPackages()) {
						imports.put(pack.getName(), formatInput(pack.getName()).toLowerCase());
					}
					context.put("importedPackages", cl.getImportedPackages());
					context.put("imports", imports);
										
					List<FMProperty> persistentProps = new ArrayList<FMProperty>();
					List<FMProperty> linkedProps = new ArrayList<FMProperty>();
					
					for (FMProperty prop : cl.getProperties()) {

						FMProperty copy = new FMProperty(prop);
						
						if (prop instanceof FMLinkedProperty) {
							linkedProps.add(prop);
						}
						else if (prop instanceof FMIdentityProperty) {
							FMIdentityProperty idCopy = new FMIdentityProperty((FMPersistentProperty)prop);
							idCopy.setStrategy(((FMIdentityProperty) prop).getStrategy());
							idCopy.setType(getCorrectType(prop.getType(), "frontend"));
							context.put("identityProp", idCopy);
						}
						else if (prop instanceof FMPersistentProperty) {
							copy.setType(getCorrectType(prop.getType(), "frontend")); 
							persistentProps.add(copy);
						}
						
					}
										
					context.put("linkedProps", linkedProps);
					context.put("persistentProps", persistentProps);
					
					getTemplate().process(context, out);
					out.flush();
				}
			} catch (TemplateException e) {
				JOptionPane.showMessageDialog(null, e.getMessage());
			} catch (IOException e) {
				JOptionPane.showMessageDialog(null, e.getMessage());
			}
		}
	}
	

	
}
