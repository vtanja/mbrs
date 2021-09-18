package myplugin.generator.fmmodel;

public class FMManytoOne extends FMLinkedProperty {
	private String columnName;
	
	public FMManytoOne(FMLinkedProperty fmProp) {
		super(fmProp.getName(), fmProp.getType(), fmProp.getVisibility(),
				fmProp.getLower(), fmProp.getUpper(), fmProp.getFetchType());
	}
	
	public FMManytoOne(String name, FMType type, String visibility, Integer lower,
			Integer upper,FetchType fetchtype, String columname){
		super(name, type, visibility, lower, upper, fetchtype);
		this.columnName = columname;
	}

	public String getColumnName() {
		return columnName;
	}

	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
		
}
