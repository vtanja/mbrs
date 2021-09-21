package myplugin.generator;

import java.io.IOException;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.swing.JOptionPane;

import freemarker.template.TemplateException;
import myplugin.generator.fmmodel.FMComponent;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.options.GeneratorOptions;
import myplugin.generator.options.TypeMapping;

public class DetailComponentHTMLGenerator extends BasicGenerator{

	public DetailComponentHTMLGenerator(GeneratorOptions generatorOptions, List<TypeMapping> typeMappings) {
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
			if(component.isDetail()) {
				Writer out;
				Map<String, Object> context = new HashMap<String, Object>();
				try {
					out = getWriter(component.getName().substring(0, 1).toLowerCase() + component.getName().substring(1), "");
					if (out != null) {
						
						context.put("component", component);
						
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
