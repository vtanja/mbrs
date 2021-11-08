package myplugin.generator.fmmodel;

public class FMManytoMany extends FMLinkedProperty {
	
	private String mappedBy;
	
	private String joinTable;
	
	public FMManytoMany(FMLinkedProperty fmProp) {
		super(fmProp.getName(), fmProp.getType(), fmProp.getVisibility(),
				fmProp.getLower(), fmProp.getUpper(), fmProp.getFetchType());
	}
	
	public FMManytoMany(String name, FMType type, String visibility, Integer lower,
			Integer upper,FetchType fetchtype, String mappedBy, String joinTable){
		super(name, type, visibility, lower, upper, fetchtype);
		this.mappedBy = mappedBy;
		this.joinTable = joinTable;
	}

	public String getMappedBy() {
		return mappedBy;
	}

	public void setMappedBy(String mappedBy) {
		this.mappedBy = mappedBy;
	}	
	
	public String getJoinTable() {
		return joinTable;
	}

	public void setJoinTable(String joinTable) {
		this.joinTable = joinTable;
	}

}
