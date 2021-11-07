package myplugin.generator;

import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.swing.JOptionPane;

import freemarker.template.TemplateException;
import myplugin.generator.fmmodel.FMClass;
import myplugin.generator.fmmodel.FMIdentityProperty;
import myplugin.generator.fmmodel.FMLinkedProperty;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.fmmodel.FMPersistentProperty;
import myplugin.generator.fmmodel.FMProperty;
import myplugin.generator.fmmodel.FMOneToMany;
import myplugin.generator.fmmodel.FMManytoOne;
import myplugin.generator.fmmodel.FMManytoMany;
import myplugin.generator.fmmodel.FMOnetoOne;
import myplugin.generator.options.GeneratorOptions;
import myplugin.generator.options.TypeMapping;

public class ModelGenerator extends BasicGenerator {

	public ModelGenerator(GeneratorOptions generatorOptions, List<TypeMapping> typeMappings) {
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
					context.put("properties", cl.getProperties());
					context.put("importedPackages", cl.getImportedPackages());
					context.put("tableName", cl.getTableName());
										
					context.put("appName", FMModel.getInstance().getApplication().getName());
					
					List<FMProperty> persistentProps = new ArrayList<FMProperty>();
					List<FMProperty> linkedProps = new ArrayList<FMProperty>();
					List<FMProperty> oneToManyProps = new ArrayList<FMProperty>();
					List<FMProperty> manyToOneProps = new ArrayList<FMProperty>();
					List<FMProperty> manyToManyProps = new ArrayList<FMProperty>();
					List<FMProperty> oneToOneProps = new ArrayList<FMProperty>();
					
					for (FMProperty prop : cl.getProperties()) {
						FMProperty copy = new FMProperty(prop);
						
						if (prop instanceof FMOneToMany) {
							oneToManyProps.add(prop);
						}
						else if (prop instanceof FMOnetoOne) {
							oneToOneProps.add(prop);
						}
						else if (prop instanceof FMManytoOne) {
							manyToOneProps.add(prop);
						}
						else if (prop instanceof FMManytoMany) {
							manyToManyProps.add(prop);
						}
						else if (prop instanceof FMLinkedProperty) {
							linkedProps.add(prop);
						}
						else if (prop instanceof FMIdentityProperty) {
							FMIdentityProperty idCopy = new FMIdentityProperty((FMPersistentProperty)prop);
							idCopy.setStrategy(((FMIdentityProperty) prop).getStrategy());
							idCopy.setType(getCorrectType(prop.getType(), "backend"));
							context.put("identityProp", idCopy);
						}
						else if (prop instanceof FMPersistentProperty) {
							copy.setType(getCorrectType(prop.getType(), "backend"));
							FMPersistentProperty perCopy = new FMPersistentProperty(copy);
							perCopy.setPrecision(((FMPersistentProperty) prop).getPrecision());
							perCopy.setLength(((FMPersistentProperty) prop).getLength());
							persistentProps.add(perCopy);
						}
						
					}
					
					context.put("linkedProps", linkedProps);
					context.put("persistentProps", persistentProps);
					context.put("oneToManyProps", oneToManyProps);
					context.put("manyToOneProps", manyToOneProps);
					context.put("manyToManyProps", manyToManyProps);
					context.put("oneToOneProps", oneToOneProps);
					
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
