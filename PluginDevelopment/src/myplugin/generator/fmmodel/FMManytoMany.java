package myplugin.generator.fmmodel;

public class FMManytoMany extends FMLinkedProperty {
	
	private String mappedBy;
	
	public FMManytoMany(FMLinkedProperty fmProp) {
		super(fmProp.getName(), fmProp.getType(), fmProp.getVisibility(),
				fmProp.getLower(), fmProp.getUpper(), fmProp.getFetchType());
	}
	
	public FMManytoMany(String name, FMType type, String visibility, Integer lower,
			Integer upper,FetchType fetchtype, String mappedBy){
		super(name, type, visibility, lower, upper, fetchtype);
		this.mappedBy = mappedBy;
	}

	public String getMappedBy() {
		return mappedBy;
	}

	public void setMappedBy(String mappedBy) {
		this.mappedBy = mappedBy;
	}	
	
	
}
