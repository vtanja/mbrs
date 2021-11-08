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

public class ListComponentHtmlGenerator extends BasicGenerator {

	public ListComponentHtmlGenerator(GeneratorOptions generatorOptions, List<TypeMapping> typeMappings) {
		super(generatorOptions, typeMappings);
		// TODO Auto-generated constructor stub
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
						
						context.put("component", component);
						context.put("entity_name", component.getName());
						
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
						
						context.put("id", FMModel.getInstance().getIdNames().get(component.getName())!=null?FMModel.getInstance().getIdNames().get(component.getName()):"");
						
						Map<String, String> paths = new HashMap<String, String>();
						for(FMField ass : associations) {
							paths.put(ass.getFmType().getName(), formatInput(ass.getFmType().getName()).toLowerCase());
						}
						
						paths.put(component.getName(), formatInput(component.getName()).toLowerCase());
						
						
						context.put("paths", paths);

						context.put("baseFields", baseFields);
						context.put("associations", associations);
						
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
