package myplugin.generator.fmmodel;

public class FMOneToMany extends FMLinkedProperty{
	private CascadeType cascade;
	private String mappedBy;
	
	public FMOneToMany(FMLinkedProperty fmProp) {
		super(fmProp.getName(), fmProp.getType(), fmProp.getVisibility(),
				fmProp.getLower(), fmProp.getUpper(), fmProp.getFetchType());
	}
	
	public FMOneToMany(String name, FMType type, String visibility, Integer lower,
			Integer upper,FetchType fetchtype, String mappedBy){
		super(name, type, visibility, lower, upper, fetchtype);
		this.mappedBy = mappedBy;
	}

	public FMOneToMany(FMProperty fmProperty) {
		super(fmProperty);
	}

	public CascadeType getCascade() {
		return cascade;
	}

	public void setCascade(CascadeType cascade) {
		this.cascade = cascade;
	}

	public String getMappedBy() {
		return mappedBy;
	}

	public void setMappedBy(String mappedBy) {
		this.mappedBy = mappedBy;
	}
}
