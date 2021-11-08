package myplugin.generator.fmmodel;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

/** FMModel: Singleton class. This is intermediate data structure that keeps metadata
 * extracted from MagicDraw model. Data structure should be optimized for code generation
 * using freemarker
 */

public class FMModel {
	
	private List<FMClass> classes = new ArrayList<FMClass>();
	private List<FMEnumeration> enumerations = new ArrayList<FMEnumeration>();
	private FMApplication application;
	private List<FMComponent> components = new ArrayList<FMComponent>();
	private Map<String, String> idNames = new HashMap<String, String>();
	
	public Map<String, String> getIdNames() {
		return idNames;
	}
	
	public void AddIdName(String component, String idName){
		idNames.put(component, idName);
	}

	//....
	/** @ToDo: Add lists of other elements, if needed */
	private FMModel() {
		
	}
	
	private static FMModel model;
	
	public static FMModel getInstance() {
		if (model == null) {
			model = new FMModel();			
		}
		return model;
	}
	
	public List<FMClass> getClasses() {
		return classes;
	}
	public void setClasses(List<FMClass> classes) {
		this.classes = classes;
	}
	public List<FMEnumeration> getEnumerations() {
		return enumerations;
	}
	public void setEnumerations(List<FMEnumeration> enumerations) {
		this.enumerations = enumerations;
	}

	public FMApplication getApplication() {
		return application;
	}

	public void setApplication(FMApplication application) {
		this.application = application;
	}

	public List<FMComponent> getComponents() {
		return components;
	}

	public void setComponents(List<FMComponent> components) {
		this.components = components;
	}

	

}
