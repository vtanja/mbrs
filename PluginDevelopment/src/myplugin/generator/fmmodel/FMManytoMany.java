package myplugin.generator.fmmodel;

public class FMManytoMany extends FMLinkedProperty {
	
	private String joinTable;
	
	public FMManytoMany(FMLinkedProperty fmProp) {
		super(fmProp.getName(), fmProp.getType(), fmProp.getVisibility(),
				fmProp.getLower(), fmProp.getUpper(), fmProp.getFetchType());
	}

	public String getJoinTable() {
		return joinTable;
	}

	public void setJoinTable(String joinTable) {
		this.joinTable = joinTable;
	}
	
	
}
