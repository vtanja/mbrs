package myplugin.generator.options;

import java.io.Serializable;

/** TypeMapping: UML 2.0 to java (or any other destination language) type mapping */

public class TypeMapping implements Serializable {
	private String uMLType;
	private String javaType;
	private String jsType;
	
	//libraryName: name used for import declaration  
	private String libraryName;
	
	public TypeMapping(String uMLType, String javaType, String libraryName, String jsType) {
		super();
		this.uMLType = uMLType;
		this.javaType = javaType;
		this.libraryName = libraryName;
		this.jsType = jsType;
	}
	
	public TypeMapping() {
		super();
	}

	public String getuMLType() {
		return uMLType;
	}

	public void setuMLType(String uMLType) {
		this.uMLType = uMLType;
	}

	public String getJavaType() {
		return javaType;
	}
	
	public String getJsType() {
		return jsType;
	}

	public void setJavaType(String javaType) {
		this.javaType = javaType;
	}

	public String getLibraryName() {
		return libraryName;
	}

	public void setLibraryName(String libraryName) {
		this.libraryName = libraryName;
	}
	
	public void setJsType(String jsType) {
		this.jsType = jsType;
	}
	
	
	
}
