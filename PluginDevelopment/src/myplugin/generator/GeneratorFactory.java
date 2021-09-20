package myplugin.generator;

import java.util.List;
import java.util.Map;

import myplugin.generator.options.GeneratorOptions;
import myplugin.generator.options.TypeMapping;

public class GeneratorFactory {
	public static BasicGenerator GetGenerator(Map.Entry<String, GeneratorOptions> entry, List<TypeMapping> typeMappings) {
		
		if(entry.getKey().equals("DTOGenerator")) {
			return new DTOGenerator(entry.getValue(), typeMappings);
		}
		else if(entry.getKey().equals("FrontDTOGenerator")) {
			return new FrontDTOGenerator(entry.getValue(), typeMappings);
		}
		
		else if(entry.getKey().equals("ControllerGenerator")) {
			return new ControllerGenerator(entry.getValue(), typeMappings);
		}
		
		else if(entry.getKey().equals("FrontModelGenerator")) {
			return new FrontModelGenerator(entry.getValue(), typeMappings);
		}
    
		else if(entry.getKey().equals("DTODetailGenerator")) {
			return new DTODetailGenerator(entry.getValue(), typeMappings);
		}
		
		else if(entry.getKey().equals("ServiceGenerator")) {
			return new ServiceGenerator(entry.getValue(), typeMappings);
		}
		
		else if(entry.getKey().equals("ServiceImplGenerator")) {
			return new ServiceImplGenerator(entry.getValue(), typeMappings);
		}
		return null;
		
	}
}
