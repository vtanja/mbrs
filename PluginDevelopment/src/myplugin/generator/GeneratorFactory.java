package myplugin.generator;

import java.util.Map;

import myplugin.generator.options.GeneratorOptions;

public class GeneratorFactory {
	public static BasicGenerator GetGenerator(Map.Entry<String, GeneratorOptions> entry) {
		
		if(entry.getKey().equals("DTOGenerator")) {
			return new DTOGenerator(entry.getValue());
		}
		
		return null;
		
	}
}
