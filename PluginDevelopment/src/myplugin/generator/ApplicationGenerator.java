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
import myplugin.generator.fmmodel.FMClass;
import myplugin.generator.fmmodel.FMIdentityProperty;
import myplugin.generator.fmmodel.FMLinkedProperty;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.fmmodel.FMPersistentProperty;
import myplugin.generator.fmmodel.FMProperty;
import myplugin.generator.options.GeneratorOptions;
import myplugin.generator.options.TypeMapping;

public class ApplicationGenerator extends BasicGenerator{
	public ApplicationGenerator(GeneratorOptions generatorOptions, List<TypeMapping> typeMappings) {
		super(generatorOptions, typeMappings);
	}

	public void generate() {
		try {
			super.generate();
		} catch (IOException e) {
			JOptionPane.showMessageDialog(null, e.getMessage());
		}
		FMApplication fmApp = FMModel.getInstance().getApplication();
		
		Writer out;
		Map<String, Object> context = new HashMap<String, Object>();
		try {
			out = getWriter(fmApp.getName().substring(0, 1).toUpperCase() + fmApp.getName().substring(1), "");
			if (out != null) {
				context.clear();
										
				context.put("appName", fmApp.getName());
				context.put("appDesc", fmApp.getDescription());
					
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
