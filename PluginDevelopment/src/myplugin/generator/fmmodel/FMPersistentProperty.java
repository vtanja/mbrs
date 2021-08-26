package myplugin.generator.fmmodel;

public class FMPersistentProperty extends FMProperty{
	private String columnName;
	private Integer length;
	private Integer precision;
	
	public FMPersistentProperty(FMProperty fmProperty) {
		super(fmProperty.getName(), fmProperty.getType(), fmProperty.getVisibility(),
				fmProperty.getLower(), fmProperty.getUpper());
	}
	
	public FMPersistentProperty(String name, FMType type, String visibility, Integer lower, Integer upper,
			String columnName, Integer precision, Integer length) {
		super(name, type, visibility, lower, upper);
		this.columnName = columnName;
		this.precision = precision;
		this.length = length;
	}
		
	public String getColumnName() {
		return columnName;
	}
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	public Integer getLength() {
		return length;
	}
	public void setLength(Integer length) {
		this.length = length;
	}
	public Integer getPrecision() {
		return precision;
	}
	public void setPrecision(Integer precision) {
		this.precision = precision;
	}

	
}
