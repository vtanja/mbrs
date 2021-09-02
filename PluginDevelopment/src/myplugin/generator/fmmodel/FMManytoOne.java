package myplugin.generator.fmmodel;

public class FMManytoOne extends FMLinkedProperty {
	private String columnName;
	
	public FMManytoOne(FMLinkedProperty fmProp) {
		super(fmProp.getName(), fmProp.getType(), fmProp.getVisibility(),
				fmProp.getLower(), fmProp.getUpper(), fmProp.getFetchType());
	}

	public String getColumnName() {
		return columnName;
	}

	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
		
}
