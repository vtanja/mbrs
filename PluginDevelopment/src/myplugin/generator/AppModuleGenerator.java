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

public class AppModuleGenerator extends BasicGenerator {

	public AppModuleGenerator(GeneratorOptions generatorOptions, List<TypeMapping> typeMappings) {
		super(generatorOptions, typeMappings);
		// TODO Auto-generated constructor stub
	}
	
	public void generate() {
		try {
			super.generate();
		} catch (IOException e) {
			JOptionPane.showMessageDialog(null, e.getMessage());
		}
		
		String name="";
		List<FMComponent> components = FMModel.getInstance().getComponents();
		
		for (int i = 0; i < components.size(); i++) {
			FMComponent cl = components.get(i);
			name+=cl.getName();
		}
		
		Writer out;
		Map<String, Object> context = new HashMap<String, Object>();
		try {
			out = getWriter(name, "");
			
			if (out != null) {
				context.clear();
										
				context.put("components", components);
					
				getTemplate().process(context, out);
				out.flush();
				//out.close();
			}
		} catch (TemplateException e) {
				JOptionPane.showMessageDialog(null, e.getMessage());
		} catch (IOException e) {
				JOptionPane.showMessageDialog(null, e.getMessage());
		}
		
	}

}
