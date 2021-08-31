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

public class FrontDTOGenerator extends BasicGenerator {
	List<TypeMapping> typeMappings;
	public FrontDTOGenerator(GeneratorOptions generatorOptions, List<TypeMapping> typeMappings) {
		super(generatorOptions);
		this.typeMappings = typeMappings;
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
					context.put("properties", cl.getProperties());
					context.put("importedPackages", cl.getImportedPackages());
					
					JOptionPane.showMessageDialog(null, typeMappings.size());
										
					List<FMProperty> persistentProps = new ArrayList<FMProperty>();
					List<FMProperty> linkedProps = new ArrayList<FMProperty>();
					
					for (FMProperty prop : cl.getProperties()) {
						if (prop instanceof FMLinkedProperty) {
							linkedProps.add(prop);
						}
						else if (prop instanceof FMIdentityProperty) {
							prop.setType(getCorrectType(prop.getType()));
							context.put("identityProp", (FMIdentityProperty)prop);
						}
						else if (prop instanceof FMPersistentProperty) {
							prop.setType(getCorrectType(prop.getType()));
							persistentProps.add(prop);
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
	

	private String getCorrectType(String type) {
		String ret = "nepoznato";
		for (TypeMapping tm : typeMappings) {
			if(tm.getuMLType().equalsIgnoreCase(type)) {
				ret = tm.getDestType();
				break;
			}
		}
		return ret;
	}
}
