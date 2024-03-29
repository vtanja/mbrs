package myplugin.generator;

import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.swing.JOptionPane;

import freemarker.template.TemplateException;
import myplugin.generator.fmmodel.FMAssociationEnd;
import myplugin.generator.fmmodel.FMClass;
import myplugin.generator.fmmodel.FMComponent;
import myplugin.generator.fmmodel.FMField;
import myplugin.generator.fmmodel.FMIdentityProperty;
import myplugin.generator.fmmodel.FMLinkedProperty;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.fmmodel.FMPersistentProperty;
import myplugin.generator.fmmodel.FMProperty;
import myplugin.generator.options.GeneratorOptions;
import myplugin.generator.options.TypeMapping;

public class FormComponentTsGenerator extends BasicGenerator{
	public FormComponentTsGenerator(GeneratorOptions generatorOptions, List<TypeMapping> typeMappings) {
		super(generatorOptions, typeMappings);
	}
	
	public void generate() {
		try {
			super.generate();
		} catch (IOException e) {
			JOptionPane.showMessageDialog(null, e.getMessage());
		}
		
		List<FMComponent> components = FMModel.getInstance().getComponents();
		for (int i = 0; i < components.size(); i++) {
			FMComponent component = components.get(i);
			if(component.isUpdate() || component.isCreate()) {
				Writer out;
				Map<String, Object> context = new HashMap<String, Object>();
				try {
					out = getWriter(formatInput(component.getName()).toLowerCase(), "");
					if (out != null) {
						
						context.put("id", FMModel.getInstance().getIdNames().get(component.getName())!=null?FMModel.getInstance().getIdNames().get(component.getName()):"");
						context.put("component", component);
						context.put("entity_name", component.getName());
						context.put("component_name", formatInput(component.getName()).toLowerCase());
						
						List<FMField> associations = new ArrayList<FMField>();
						List<FMField> baseFields = new ArrayList<FMField>();
												
						for(FMField field : component.getFields()) {
							if(field instanceof FMAssociationEnd) {
								associations.add(field);
							}
							else {
								baseFields.add(field);
							}
						}
						
						Map<String, String> ids = new HashMap<String, String>();
						
						for(FMField ass : associations) {
							if(FMModel.getInstance().getIdNames().get(ass.getFmType().getName()) != null) {
								ids.put(ass.getFmType().getName(), FMModel.getInstance().getIdNames().get(ass.getFmType().getName()));
							}
							else {
								ids.put(ass.getFmType().getName(), "id");
							}
						}
						

						Map<String, String> paths = new HashMap<String, String>();
						for(FMField ass : associations) {
							paths.put(ass.getFmType().getName(), formatInput(ass.getFmType().getName()).toLowerCase());
						}
						
						context.put("assId", ids);
						context.put("baseFields", baseFields);
						context.put("associations", associations);
						context.put("paths", paths);
						
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
}
