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
import myplugin.generator.fmmodel.FMPersistentProperty;
import myplugin.generator.fmmodel.FMLinkedProperty;
import myplugin.generator.options.GeneratorOptions;
import myplugin.generator.options.TypeMapping;

public class ServiceGenerator extends BasicGenerator {
	
	public ServiceGenerator(GeneratorOptions generatorOptions, List<TypeMapping> typeMappings) {
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
				out = getWriter(cl.getName(), cl.getTypePackage());
				if (out != null) {
					context.clear();
					context.put("class", cl);
					context.put("name", cl.getName());
					context.put("repository", cl.getName().toLowerCase() + "Repository");
					context.put("properties", cl.getProperties());
					context.put("id", FMModel.getInstance().getIdNames().get(cl.getName())!=null?FMModel.getInstance().getIdNames().get(cl.getName()):"Id");
					context.put("appName", FMModel.getInstance().getApplication().getName());
										
					List<FMProperty> persistentProps = new ArrayList<FMProperty>();
					List<FMProperty> linkedProps = new ArrayList<FMProperty>();
					List<String> imports = new ArrayList<String>();
					
					for (FMProperty prop : cl.getProperties()) {
						FMProperty copy = new FMProperty(prop);
						
						if (prop instanceof FMLinkedProperty) {
							linkedProps.add(prop);
							if(imports.indexOf(prop.getType().getName())==-1) {
								imports.add(prop.getType().getName());
							}
						}
						else if (prop instanceof FMIdentityProperty) {
							FMIdentityProperty idCopy = new FMIdentityProperty((FMPersistentProperty)prop);
							idCopy.setStrategy(((FMIdentityProperty) prop).getStrategy());
							idCopy.setType(getCorrectType(prop.getType(), "backend"));
							context.put("identityProp", idCopy);
						}
						else if (prop instanceof FMPersistentProperty) {
							copy.setType(getCorrectType(prop.getType(), "backend")); 
							persistentProps.add(copy);
						}
						
					}
										
					context.put("linkedProps", linkedProps);
					context.put("persistentProps", persistentProps);
					context.put("imports", imports);
					
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
