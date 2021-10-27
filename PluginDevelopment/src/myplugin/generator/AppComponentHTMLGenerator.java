package myplugin.generator;

import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.swing.JOptionPane;

import freemarker.template.TemplateException;
import myplugin.generator.fmmodel.FMApplication;
import myplugin.generator.fmmodel.FMComponent;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.options.GeneratorOptions;
import myplugin.generator.options.TypeMapping;

public class AppComponentHTMLGenerator extends BasicGenerator {
	public AppComponentHTMLGenerator(GeneratorOptions generatorOptions, List<TypeMapping> typeMappings) {
		super(generatorOptions, typeMappings);
	}

	public void generate() {
		try {
			super.generate();
		} catch (IOException e) {
			JOptionPane.showMessageDialog(null, e.getMessage());
		}
		
		
		Writer out;
		Map<String, Object> context = new HashMap<String, Object>();
		try {
			out = getWriter("", "");
			if (out != null) {
				context.clear();
								
				Map<String, FMComponent> components = new HashMap<String, FMComponent>();
				
				for(FMComponent comp :FMModel.getInstance().getComponents()){
					components.put(formatInput(comp.getName()).toLowerCase(), comp);
				}
				
				context.put("components", components);
				
				List<String> componentNames = new ArrayList<String>();
				
				for(Map.Entry<String, FMComponent> comp : components.entrySet()) {
					componentNames.add(formatInput(comp.getValue().getName()).toLowerCase());
				}
				
				context.put("componentNames", componentNames);
				
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
