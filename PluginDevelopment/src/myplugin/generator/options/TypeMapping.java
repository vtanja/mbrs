package myplugin.generator.options;

import java.io.Serializable;

/** TypeMapping: UML 2.0 to java (or any other destination language) type mapping */

public class TypeMapping implements Serializable {
	private String uMLType;
	private String destType;
	private String destination;
	
	//libraryName: name used for import declaration  
	private String libraryName;
	
	public TypeMapping(String uMLType, String destType, String libraryName, String destination) {
		super();
		this.uMLType = uMLType;
		this.destType = destType;
		this.libraryName = libraryName;
		this.destination = destination;
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

	public String getDestType() {
		return destType;
	}
	
	public String getDestination() {
		return destination;
	}

	public void setDestType(String destType) {
		this.destType = destType;
	}

	public String getLibraryName() {
		return libraryName;
	}

	public void setLibraryName(String libraryName) {
		this.libraryName = libraryName;
	}
	
	public void setDestination(String destination) {
		this.destination = destination;
	}
	
	
	
}
