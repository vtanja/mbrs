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
		
		else if(entry.getKey().equals("RepositoryGenerator")) {
			return new RepositoryGenerator(entry.getValue(), typeMappings);
		}
		
		else if(entry.getKey().equals("ModelGenerator")) {
			return new ModelGenerator(entry.getValue(), typeMappings);
		}
		

		if(entry.getKey().equals("FrontServiceGenerator")) {
			return new FrontServiceGenerator(entry.getValue(), typeMappings);
    }

		if(entry.getKey().equals("PomXmlGenerator")) {
			return new PomXmlGenerator(entry.getValue(), typeMappings);
		}
		
		if(entry.getKey().equals("ApplicationGenerator")) {
			return new ApplicationGenerator(entry.getValue(), typeMappings);

		}
		
		return null;
		
	}
}
