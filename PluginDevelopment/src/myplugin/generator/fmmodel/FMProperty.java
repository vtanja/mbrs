package myplugin.generator.fmmodel;


public class FMProperty extends FMElement  {
	//Property type
	private FMType type;
	// Property visibility (public, private, protected, package)
	private String visibility;
	//Multiplicity (lower value)
	private Integer lower;
	//Multiplicity (upper value) 
	private Integer upper;
	
	/** @ToDo: Add length, precision, unique... whatever is needed for ejb class generation
	 * Also, provide these meta-attributes or tags in the modeling languange metaclass or 
	 * stereotype */

	
	public FMProperty(String name, FMType type, String visibility, int lower, int upper) {
		super(name);
		this.type = type;
		this.visibility = visibility;
		
		this.lower = lower;
		this.upper = upper;		
	}
	
	public FMProperty(FMProperty fmProp) {
		super(fmProp.getName());
		this.type = fmProp.getType();
		this.visibility = fmProp.getVisibility();
		
		this.lower = fmProp.getLower();
		this.upper = fmProp.getUpper();		
	}
	
	public FMType getType() {
		return type;
	}
	public void setType(FMType type) {
		this.type = type;
	}
	public String getVisibility() {
		return visibility;
	}
	public void setVisibility(String visibility) {
		this.visibility = visibility;
	}
	
	public Integer getLower() {
		return lower;
	}

	public void setLower(Integer lower) {
		this.lower = lower;
	}

	public Integer getUpper() {
		return upper;
	}

	public void setUpper(Integer upper) {
		this.upper = upper;
	}
}
