package myplugin.generator;

import java.util.Map;

import myplugin.generator.options.GeneratorOptions;

public class GeneratorFactory {
	public static BasicGenerator GetGenerator(Map.Entry<String, GeneratorOptions> entry) {
		// ovo je samo test primer koji treba obrisati kada se doda prvi generator 
		if(entry.getKey().equals("EJBGenerator")) {
			return new EJBGenerator(entry.getValue());
		}
			
		return null;
		
	}
}
