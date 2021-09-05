package myplugin.generator.fmmodel;

public class FMManytoMany extends FMLinkedProperty {
	
	private String mappedBy;
	
	public FMManytoMany(FMLinkedProperty fmProp) {
		super(fmProp.getName(), fmProp.getType(), fmProp.getVisibility(),
				fmProp.getLower(), fmProp.getUpper(), fmProp.getFetchType());
	}

	public String getMappedBy() {
		return mappedBy;
	}

	public void setMappedBy(String mappedBy) {
		this.mappedBy = mappedBy;
	}	
	
	
}
