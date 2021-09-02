package myplugin.generator;

import java.util.List;
import java.util.Map;

import myplugin.generator.options.GeneratorOptions;
import myplugin.generator.options.TypeMapping;

public class GeneratorFactory {
	public static BasicGenerator GetGenerator(Map.Entry<String, GeneratorOptions> entry, List<TypeMapping> typeMappings) {
		
		if(entry.getKey().equals("DTOGenerator")) {
			return new DTOGenerator(entry.getValue());
		}
		else if(entry.getKey().equals("FrontDTOGenerator")) {
			return new FrontDTOGenerator(entry.getValue(), typeMappings);
		}
		
		if(entry.getKey().equals("ControllerGenerator")) {
			return new ControllerGenerator(entry.getValue());
		}
		
		return null;
		
	}
}
