package myplugin.generator;

import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.swing.JOptionPane;

import freemarker.template.TemplateException;
import myplugin.generator.fmmodel.FMClass;
import myplugin.generator.fmmodel.FMEnumeration;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.options.GeneratorOptions;
import myplugin.generator.options.TypeMapping;

public class EnumGenerator extends BasicGenerator {

	public EnumGenerator(GeneratorOptions generatorOptions, List<TypeMapping> typeMappings) {
		super(generatorOptions, typeMappings);
	}
	
	public void generate() {
		try {
			super.generate();
		} catch (IOException e) {
			JOptionPane.showMessageDialog(null, e.getMessage());
		}
		
		List<FMEnumeration> enums = FMModel.getInstance().getEnumerations();
		for (int i = 0; i < enums.size(); i++) {
			FMEnumeration en = enums.get(i);
			Writer out;
			Map<String, Object> context = new HashMap<String, Object>();
			try {
				out = getWriter(en.getName(), "");
				if (out != null) {
					context.clear();
					context.put("name", en.getName());

					List<String> values = new ArrayList<String>();
					
					Iterator<String> enit = en.getValueIterator();
					while(enit.hasNext()) {
						values.add(enit.next());
					}
//					
//					for(int j = 0; j<en.getValuesCount(); j++) {
//						values.add(en.getValueAt(j));
//					}
					context.put("values", values);
					context.put("appName", FMModel.getInstance().getApplication().getName());
					
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
