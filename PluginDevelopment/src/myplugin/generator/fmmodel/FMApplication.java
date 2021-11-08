package myplugin.generator.fmmodel;

public class FMApplication {
	private String name;
	private String description;

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public FMApplication() {
		
	}
	
	public FMApplication(String name, String description) {
		this.name = name;
		this.description = description;
	}
}
