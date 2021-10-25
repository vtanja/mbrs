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
		
		else if(entry.getKey().equals("DTOImplGenerator")) {
			return new DTOImplGenerator(entry.getValue(), typeMappings);
		}
		
		else if(entry.getKey().equals("FrontDTOGenerator")) {
			return new FrontDTOGenerator(entry.getValue(), typeMappings);
		}
		
		else if(entry.getKey().equals("ControllerGenerator")) {
			return new ControllerGenerator(entry.getValue(), typeMappings);
		}
		
		else if(entry.getKey().equals("ControllerImplGenerator")) {
			return new ControllerImplGenerator(entry.getValue(), typeMappings);
		}
		
		else if(entry.getKey().equals("FrontModelGenerator")) {
			return new FrontModelGenerator(entry.getValue(), typeMappings);
		}
    
		else if(entry.getKey().equals("DTODetailGenerator")) {
			return new DTODetailGenerator(entry.getValue(), typeMappings);
		}
		
		else if(entry.getKey().equals("DTODetailImplGenerator")) {
			return new DTODetailImplGenerator(entry.getValue(), typeMappings);
		}
		
		else if(entry.getKey().equals("ServiceGenerator")) {
			return new ServiceGenerator(entry.getValue(), typeMappings);
		}
		
		else if(entry.getKey().equals("ServiceImplGenerator")) {
			return new ServiceImplGenerator(entry.getValue(), typeMappings);
		}
		
		else if(entry.getKey().equals("RepositoryGenerator")) {
			return new RepositoryGenerator(entry.getValue(), typeMappings);
		}
		
		else if(entry.getKey().equals("RepositoryImplGenerator")) {
			return new RepositoryImplGenerator(entry.getValue(), typeMappings);
		}
		
		else if(entry.getKey().equals("ModelGenerator")) {
			return new ModelGenerator(entry.getValue(), typeMappings);
		}
		
		else if(entry.getKey().equals("FrontServiceGenerator")) {
			return new FrontServiceGenerator(entry.getValue(), typeMappings);
		}

		else if(entry.getKey().equals("PomXmlGenerator")) {
			return new PomXmlGenerator(entry.getValue(), typeMappings);
		}
		
		else if(entry.getKey().equals("ApplicationGenerator")) {
			return new ApplicationGenerator(entry.getValue(), typeMappings);

		}
		
		else if(entry.getKey().equals("DetailComponentGenerator")) {
			return new DetailComponentGenerator(entry.getValue(), typeMappings);
		}
		
		else if(entry.getKey().equals("DetailComponentHTMLGenerator")) {
			return new DetailComponentHTMLGenerator(entry.getValue(), typeMappings);
		}
		
		else if(entry.getKey().equals("AppRoutingGenerator")) {
			return new AppRoutingGenerator(entry.getValue(), typeMappings);
		}
		
		else if(entry.getKey().equals("WebSecurityConfigGenerator")) {
			return new WebSecurityConfigGenerator(entry.getValue(), typeMappings);
		}
		
		else if(entry.getKey().equals("AppModuleGenerator")) {
			return new AppModuleGenerator(entry.getValue(), typeMappings);
		}
		
		return null;
		
	}
}
